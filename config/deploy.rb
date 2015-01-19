default_run_options[:pty] = true

require "bundler/capistrano"

set :application, "RedMine"
set :repository,  "git@github.com:Madwagon/redmine"
set :scm, "git"
set :ssh_options, {:forward_agent => true}

server "europe1.dagoba.co", :web, :app, :db, primary: true
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :branch, '2.6-stable'


# if you want to clean up old releases on each deploy uncomment this:
after "deploy", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
	task :start do
		;
	end
	task :stop do
		;
	end
	task :restart, :roles => :app, :except => { :no_release => true } do
		run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
	end

	task :setup_config, roles: :app do
		sudo "mkdir -p #{shared_path}/config"
		sudo "mkdir -p #{shared_path}/files"
		#bundle instaput File.read("config/database.yml"), "#{shared_path}/config/database.yml"
	end
	after "deploy:setup", "deploy:setup_config"

	task :symlink_config, roles: :app do
		puts "symlink_config"
		run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
		run "ln -nsf #{shared_path}/files #{release_path}/files"
#		run "mkdir -p tmp tmp/pdf public/plugin_assets"
#		sudo "chown -R deployer files tmp public/plugin_assets"
#		sudo "chmod -R 755 files tmp public/plugin_assets"
	end
	after "deploy:finalize_update", "deploy:symlink_config"

	desc "Make sure local git is in sync with remote."
	task :check_revision, roles: :web do
		#unless `git rev-parse HEAD` == `git rev-parse origin/master`
		#  puts "WARNING: HEAD is not the same as origin/master"
		#  puts "Run `git push` to sync changes."
		#  exit
		#end
	end
	before "deploy", "deploy:check_revision"
end
