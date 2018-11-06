require 'benchmark'

module CiReporterShell
  class Capture
    attr_reader :command

    def initialize(command)
      @command = command
    end

    def execute
      stdout = Tempfile.new('stdout')
      stderr = Tempfile.new('stderr')

      time = status = nil
      
      unless command.nil? || command.empty?
        IO.popen(['tee', stdout.path], 'w') do |out|
          IO.popen(['tee', stderr.path], 'w') do |err|
            time = ::Benchmark.realtime do
              _, status = ::Process.wait2 ::Process.spawn(*command.to_a,
                                                          out: out,
                                                          err: err,
                                                          umask: File.umask)
            end
          end
        end
      else
        File.open('/tmp/failure', 'w') do |f|
          f.puts "passed in a broken command #{command.inspect}"
        end
      end

      CiReporterShell::Result.new(stdout: stdout,
                                  stderr: stderr,
                                  status: status,
                                  time: time)
    end
  end
end
