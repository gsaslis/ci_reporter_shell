RSpec.describe CiReporterShell::Report do
  subject(:report) { described_class.new('shell') }

  let(:env) { { FOOBAR: 'foobar' } }
  let(:cmd) { 'echo $FOOBAR' }

  describe '#command' do
    subject(:command) { report.command(cmd, env: env) }

    it { is_expected.to be_a(CiReporterShell::Command) }
    it { is_expected.to eq('FOOBAR=foobar echo $FOOBAR') }
  end

  describe '#execute' do
    subject(:execute) { report.execute(cmd, env: env) }

    it { is_expected.to be_a(CiReporterShell::Result) }

    describe 'failure' do
      subject(:execute) { report.execute('echo $FOOBAR; false', env: { FOOBAR: 'foobar' })}
      it { is_expected.not_to be_success }
    end
  end
end
