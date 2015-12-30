require 'ci_reporter_shell/capture'

RSpec.describe CiReporterShell::Capture do
  subject(:capture) { described_class.new([{'FOOBAR' => '1'}, 'echo ${FOOBAR}']) }

  context '#execute' do
    subject(:result) { capture.execute }
    it { is_expected.to be_a(CiReporterShell::Result) }

    context 'result.stdout' do
      subject(:stdout) { result.stdout.read }
      it { is_expected.to eq("1\n") }
    end
  end
end
