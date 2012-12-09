# run unicorn with unicorn -c Rails.root/current/config/unicorn.rb -E production -D

rails_env = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'production'

# 12 workers and 1 master
worker_processes (rails_env == 'production' ? 12 : 4)

# Load rails+github.git into the master before forking workers
# for super-fast worker spawn times
preload_app true

# Restart any workers that haven't responded in 30 seconds
timeout 30

# Listen on a Unix data socket
listen '/tmp/unicorn.sock', :backlog => 2048

#run unicorn on your local machine by local=true bundle exec unicorn -c config/unicorn
if ENV['local']
  RAILS_ROOT_PATH = File.expand_path("../..", __FILE__)
else
  RAILS_ROOT_PATH = "/home/deploy/feed_fiction/current"
end

pid RAILS_ROOT_PATH+"/tmp/pids/unicorn.pid"


# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
working_directory RAILS_ROOT_PATH


##
# REE

# http://www.rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

#this line of code is to be used to make sure that the current gemfile is always used.
before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = RAILS_ROOT_PATH+"/Gemfile"
end


before_fork do |server, worker|
  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.

  old_pid = RAILS_ROOT_PATH + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  ActiveRecord::Base.connection_handler.clear_all_connections!
end


after_fork do |server, worker|
  ##
  # Unicorn master loads the app then forks off workers - because of the way
  # Unix forking works, we need to make sure we aren't using any of the parent's
  # sockets, e.g. db connection

  ActiveRecord::Base.connection_handler.verify_active_connections!

  # Redis and Memcached would go here but their connections are established
  # on demand, so the master never opens a socket


  ##
  # Unicorn master is started as root, which is fine, but let's
  # drop the workers to git:git

  begin
    uid, gid = Process.euid, Process.egid
    user, group = 'deploy', 'deploy'
    target_uid = Etc.getpwnam(user).uid
    target_gid = Etc.getgrnam(group).gid
    worker.tmp.chown(target_uid, target_gid)
    if uid != target_uid || gid != target_gid
      Process.initgroups(user, target_gid)
      Process::GID.change_privilege(target_gid)
      Process::UID.change_privilege(target_uid)
    end
  rescue => e
    if RAILS_ENV == 'development'
      STDERR.puts "couldn't change user, oh well"
    else
      raise e
    end
  end
end