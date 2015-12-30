require 'benchmark'

module CiReporterShell
  class Capture
    attr_reader :command

    def initialize(command)
      @command = command
    end

    def execute
      read_stdout, write_stdout = IO.pipe
      read_stderr, write_stderr = IO.pipe

      status = nil

      time = ::Benchmark.realtime do
        pid = ::Process.spawn(*command.to_a, out: write_stdout, err: write_stderr)

        _, status = ::Process.wait2(pid)
      end

      write_stderr.close
      write_stdout.close

      CiReporterShell::Result.new(stdout: read_stdout,
                                  stderr: read_stderr,
                                  status: status,
                                  time: time)
    end
  end
end
