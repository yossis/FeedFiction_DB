require "rvm/capistrano"

set :application, "FeedFiction"
set :repository,  "git@github.com:yossis/FeedFiction_DB.git"

set :scm, :git
set :deploy_via, :remote_cache

set :use_sudo, false
set :user, "deploy"

set :deploy_to, "/home/deploy/feed_fiction"
set :current_path, "/home/deploy/feed_fiction/current"

role :web, "198.74.61.35"                          # Your HTTP server, Apache/etc
role :app, "198.74.61.35"                          # This may be the same as your `Web` server
role :db,  "198.74.61.35", :primary => true # This is where Rails migrations will run

set :rvm_type, :system
set :rvm_ruby_string, "1.9.3-turbo"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end