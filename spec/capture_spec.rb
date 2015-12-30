require 'ci_reporter_shell/capture'

RSpec.describe CiReporterShell::Capture do
  subject(:capture) { described_class.new([{'FOOBAR' => '1'}, 'echo ${FOOBAR}']) }

  context '#execute' do
    subject(:execute) { capture.execute }
    it { is_expected.to be_a(CiReporterShell::Result) }
  end
end
