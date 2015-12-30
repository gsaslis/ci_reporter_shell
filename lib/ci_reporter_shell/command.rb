require 'ci/reporter/output_capture'
require 'shellwords'
require 'ci_reporter_shell/result'
require 'ci_reporter_shell/capture'

module CiReporterShell
  class Command
    ESCAPE = Shellwords.method(:escape)

    attr_reader :env, :command, :args

    def initialize(command, *args, env: {})
      @command = command
      @args = args
      @env = env
    end

    def to_s
      env_string = env.map{ |k,v| [k,v].map(&ESCAPE).join('=') }
      args_string = args.map(&ESCAPE)
      cmd_string = escape_needed? ? ESCAPE.(command) : command

      [*env_string, cmd_string, *args_string].join(' ')
    end

    def to_a
      [env.map{|k,v| [k.to_s, v.to_s] }.to_h, command.to_s, *args.map(&:to_s)]
    end

    def escape_needed?
      args.any? && Shellwords.split(command).one?
    end

    def ==(other)
      super || other == to_s
    end

    def execute
      capture = CiReporterShell::Capture.new(self)
      capture.execute
    end
  end
end
