require 'ci/reporter/report_manager'
require 'ci/reporter/test_suite'

module CiReporterShell
  class Report
    attr_reader :report_manager

    def initialize(name)
      @report_manager = ::CI::Reporter::ReportManager.new(name)
    end

    # @yieldparam command [CiReporterShell::Command]
    # @return [CiReporterShell::Result]
    def execute(cmd, env: {})
      cmd = command(cmd, env: env)
      yield cmd if block_given?
      result = cmd.execute
      report(cmd, result)
      result
    end

    def command(cmd, env: {})
      Command.new(cmd, env: env)
    end

    def report(command, result)
      suite = ::CI::Reporter::TestSuite.new(command.to_s)
      suite.stderr = result.stderr.read
      suite.stdout = result.stdout.read

      test_case = ::CI::Reporter::TestCase.new(command.to_s, result.time)

      unless result.success?
        test_case.failures << Failure.new(command, result)
      end

      suite.testcases << test_case
      suite.failures = test_case.failures.size

      report_manager.write_report(suite)
    end
  end
end

