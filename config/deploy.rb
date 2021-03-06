# -*- encoding : utf-8 -*-
require 'capistrano/ext/multistage'

set :stages, ["staging", "production"]
set :default_stage, "staging"
set :application, 'kecheng'
set :repository, 'git@github.com:wenhuizhao/kecheng.git'
set :ssh_options, {:forward_agent => true}
default_run_options[:pty] = true

set :scm, :git
set :use_sudo, false

set :user, "deploy"

set :deploy_via, :remote_cache

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:create_symlink","deploy:db_migrate", "deploy:db_seed", "deploy:asset", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   desc "Symlinks the database.ym"
   task :create_symlink, :roles => :app do
     run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
   end
   desc "Precompile Assets"
   task :asset, :roles => :app do
     %x[bundle exec rake assets:precompile]
   end
   task :db_migrate, :roles => :db do
     %x[bundle exec rake db:migrate]
   end
   task :db_seed, :roles => :db do
     %x[bundle exec rake db:seed]
   end
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end
