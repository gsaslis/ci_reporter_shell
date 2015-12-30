require 'forwardable'

module CiReporterShell
  class Result
    extend Forwardable

    attr_reader :status, :time, :stderr, :stdout

    def_delegators :status, :success?

    def initialize(stdout:, stderr:, status:, time:)
      @stdout = stdout
      @stderr = stderr
      @status = status
      @time = time
    end
  end
end
