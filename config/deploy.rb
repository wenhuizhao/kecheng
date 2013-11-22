# -*- encoding : utf-8 -*-
set :application, 'kecheng'
set :repository, 'git@github.com:wenhuizhao/kecheng.git'
set :branch, "develop"
set :ssh_options, {:forward_agent => true}
default_run_options[:pty] = true

set :deploy_to, '/var/www/kecheng'
set :scm, :git
set :use_sudo, false

set :user, "deploy"

set :deploy_via, :remote_cache

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "dev.bigsai.com"                          # Your HTTP server, Apache/etc
role :app, "dev.bigsai.com"                          # This may be the same as your `Web` server
role :db,  "dev.bigsai.com", :primary => true # This is where Rails migrations will run
role :db,  "dev.bigsai.com"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
#namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
#end
