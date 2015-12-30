RSpec.describe CiReporterShell::Result do
  subject(:result) { described_class.new(stdout: stdout, stderr: stderr, time: time, status: status) }

  let(:stdout) { StringIO.new }
  let(:stderr) { StringIO.new }
  let(:time)   { 1.24 }

  describe '#success?' do
    subject { result.success? }

    context 'successful status' do
      let(:status) { system('true'); $? }
      it { is_expected.to be }
    end

    context 'failure status' do
      let(:status) { system('false'); $? }
      it { is_expected.not_to be }
    end
  end
end
