module CiReporterShell
  class Failure
    attr_reader :command, :result

    def initialize(command, result)
      @command = command
      @result = result
    end

    def error?
      false
    end

    def name
      result.status
    end

    def message
      "FAILURE in #{'%.1fs' % result.time}"
    end

    def location
      @command.to_s
    end

  end
end
