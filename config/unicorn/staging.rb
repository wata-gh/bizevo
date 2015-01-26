root_path = File.expand_path '../../', File.dirname(__FILE__)

# files
pid root_path + '/unicorn.pid'
stderr_path root_path + '/log/unicorn.stderr.log'
stdout_path root_path + '/log/unicorn.stdout.log'

# settings
worker_processes 1
listen 8010
listen '/tmp/unicorn.sock', backlog: 1024
timeout 300

# fork
before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
  sleep 1
end
