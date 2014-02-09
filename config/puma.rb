threads 1,4
workers 1
bind 'tcp://0.0.0.0:3007'
daemonize true
state_path "/var/www/todo/shared/tmp/pids/puma.state"
pidfile "/var/www/todo/shared/tmp/pids/puma.pid"
environment 'production'