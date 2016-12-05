lock '3.6.1'

set :application, 'gobierto-budgets-data'
set :repo_url, 'git@github.com:PopulateTools/gobierto-budgets-data.git'
set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')
set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'
set :rbenv_path, '/home/ubuntu/.rbenv'
