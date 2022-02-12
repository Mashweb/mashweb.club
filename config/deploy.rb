lock "~> 3.16.0"

# replace obvious parts
server '188.166.126.57', port: 22, roles: [:web, :app, :db], primary: true
set :application, "mashweb"
set :repo_url, "https://github.com/Mashweb/mashweb.club"

set :user, 'rails'
set :puma_threads,    [4, 16]
set :puma_workers,    0

set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
set :puma_service_unit_env_file, '/etc/environment'

# SSL
set :nginx_ssl_certificate, "/home/#{fetch(:user)}/keys/mashweb_club.crt"
set :nginx_ssl_certificate_key, "/home/#{fetch(:user)}/keys/privatekey_.key"
set :nginx_use_ssl, true

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "public/uploads", "tmp/sockets"
