root = "/home/dev/mgblog"
working_directory root
pid "#{root}/shared/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

worker_processes 4
timeout 30
preload_app true
listen "#{root}/shared/sockets/unicorn.sock", backlog: 64
before_fork do |server,worker|
	Signal.trap 'TERM' do
		puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
		Process.kill 'KILL'. Process.pid
	end
end
after_fork do |server,worker|
	Signal.trap 'TERM' do
		puts 'Unicorn master intercepting TERM and doing nothing.Wait for master to send QUIT'
	end
end
before_exec do |_|
	ENV["BUNDLE_GEMFILE"] = File.join(root, "Gemfile")
end
