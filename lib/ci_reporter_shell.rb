require 'ci_reporter_shell/version'

module CiReporterShell
  autoload :Command, 'ci_reporter_shell/command'
  autoload :Result, 'ci_reporter_shell/result'
  autoload :Report, 'ci_reporter_shell/report'
  autoload :Failure, 'ci_reporter_shell/failure'

  module_function

  def report
    CiReporterShell::Report.new('shell')
  end
end
