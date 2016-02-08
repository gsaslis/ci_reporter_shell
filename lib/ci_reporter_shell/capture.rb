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

      CiReporterShell::Result.new(stdout: stdout,
                                  stderr: stderr,
                                  status: status,
                                  time: time)
    end
  end
end
