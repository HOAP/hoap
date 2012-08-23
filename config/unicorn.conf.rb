listen "/tmp/unicorn.sock"
worker_processes 3
working_directory "/usr/local/www/hoap"
pid "/var/run/unicorn.pid"
stderr_path "/var/log/unicorn.log"
stdout_path "/var/log/unicorn.log"
