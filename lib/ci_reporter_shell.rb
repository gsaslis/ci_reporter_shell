require 'ci_reporter_shell/version'

module CiReporterShell
  autoload :Command, 'ci_reporter_shell/command'
  autoload :Result, 'ci_reporter_shell/result'
  autoload :Report, 'ci_reporter_shell/report'
  autoload :Failure, 'ci_reporter_shell/failure'

  module_function

  def report(path = nil)
    ci_reports = ENV['CI_REPORTS']
    ENV['CI_REPORTS'] = path
    CiReporterShell::Report.new('shell')
  ensure
    ENV['CI_REPORTS'] = ci_reports
  end
end
