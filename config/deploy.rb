# config valid only for Capistrano 3.1
lock '3.4.0'

set :application, 'bizevo'
set :repo_url, 'https://github.com/wata-gh/bizevo.git'
set :deploy_to, "/opt/bizevo/#{fetch(:stage)}"
set :keep_releases, 5
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets tmp/conf bundle public/system}
set :unicorn_rack_env, fetch(:stage)
set :bundle_jobs, 4

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart
end
