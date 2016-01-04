## Unicorn configuration

application_path = File.expand_path(File.dirname(__FILE__) + '/..')
working_directory  = application_path


## Unicorn PID file location
pid "#{application_path}/tmp/pids/unicorn.pid"

## Logs location
stderr_path "#{application_path}/log/unicorn.log"
stdout_path "#{application_path}/log/unicorn.log"

# Number of processes worker
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 8)

## Unicorn socket
listen "#{application_path}/tmp/unicorn.sock", backlog: 64
#listen(3000, backlog: 64) if ENV['RAILS_ENV'] == 'development'

## Timeout configuration
timeout 60

before_fork do |server, worker|

end

after_fork do |server, worker|
  #  begin
  #   require 'hyrax'
  #   Hyrax.connect
  #   puts 'after hyrex connect'
  # rescue Exception => e
  #   puts e
  #   end
end