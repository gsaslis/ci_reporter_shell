require 'ci_reporter_shell'

RSpec.describe CiReporterShell do
  describe '#report' do
    subject(:report) { described_class.report }

    it { is_expected.to be_a(CiReporterShell::Report) }
  end
end
