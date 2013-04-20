require "rvm/capistrano"

set :application, "FeedFiction"
set :repository,  "git@github.com:yossis/FeedFiction_DB.git"

set :scm, :git
set :deploy_via, :remote_cache
set :branch, :master

set :use_sudo, false
set :user, "deploy"

set :deploy_to, "/home/deploy/feed_fiction"
set :current_path, "/home/deploy/feed_fiction/current"

role :web, "198.74.61.35"                          # Your HTTP server, Apache/etc
role :app, "198.74.61.35"                          # This may be the same as your `Web` server
role :db,  "198.74.61.35", :primary => true # This is where Rails migrations will run
role :sidekiq, "198.74.61.35"

set :rvm_type, :system
set :rvm_ruby_string,   "1.9.3-p327-turbo"

set :rake, "bundle exec rake"

set :rails_env, "production"

before "deploy:assets:precompile", "deploy:bundle_install"
after "deploy:bundle_install", "deploy:migrate"
after "deploy:restart", "sidekiq:restart"


namespace :deploy do

  task :quick do
    run "cd #{current_path}; git pull origin #{branch}"
    restart
  end

  task :bundle_install do
    run "cd #{release_path}; bundle install --quiet"
  end

  task :migrate do
    run "cd #{release_path}; bundle exec rake db:migrate RAILS_ENV=#{rails_env}"
  end

  task :start, :roles => :web, :except => { :no_release => true } do 
    run "cd #{current_path} && rvmsudo unicorn -c config/unicorn.rb -E #{rails_env} -D"
  end

  task :stop, :roles => :web, :except => { :no_release => true } do 
    run "ps aux | grep unicorn | grep master | grep -v grep | awk {'print $2'} | xargs -r sudo kill -s QUIT"
  end
  
  #notice that we're doing sort of a rolling restart, that's not it (there's no sleep) but because we check if there's a running unicorn server before we send the USR2 we need to run the tasks for each server separately
  # unicorn_binary is the command used to run unicorn (bundle exec unicorn) and the unicorn_config is the path to the config file
  task :restart, :roles => :web, :except => { :no_release => true } do
    servers = find_servers_for_task(current_task)
    servers.each do |server|
      grep = capture "ps aux | grep unicorn | grep master | grep -v grep; true", :hosts => server
      #if unicorn isn't running, start it
      if grep.to_s == ""
        run "cd #{current_path} && rvmsudo unicorn -c config/unicorn.rb -E #{rails_env} -D", :hosts => server
      else
        #otherwise, restart
        run "sudo kill -s USR2 `cat #{current_path}/tmp/pids/unicorn.pid`", :hosts => server
      end
    end
  end

end

namespace :sidekiq do
  task :start, roles: :sidekiq do
    run "cd #{current_path}; bundle exec sidekiq -e #{rails_env} > log/sidekiq.log 2>&1 &", :pty => false
  end

  task :stop, roles: :sidekiq do
    run "ps aux | grep sidekiq | grep -v grep | awk {'print $2'} | xargs -r sudo kill -s QUIT"
  end

  task :restart, roles: :sidekiq do
    stop
    start
  end
end