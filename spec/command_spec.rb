require 'ci_reporter_shell/command'

RSpec.describe CiReporterShell::Command do
  subject(:command) { described_class.new('bash', '-c', 'foo.sh', env: { REPORT: 1 })}

  describe '#to_s' do
    subject { command.to_s }

    it { is_expected.to eq('REPORT=1 bash -c foo.sh') }
  end

  describe '#==' do
    it { is_expected.to eq('REPORT=1 bash -c foo.sh') }
  end

  describe '#execute' do
    let(:command) { described_class.new('echo $FOOBAR', env: { FOOBAR: 1 })}
    subject { command.execute }

    it { is_expected.to be_a(CiReporterShell::Result) }
  end

  describe '#to_a' do
    subject { command.to_a }
    it { is_expected.to eq([{'REPORT'=>'1'}, 'bash', '-c', 'foo.sh']) }
  end

  context 'escaping' do
    context 'with arguments' do
      subject(:command) { described_class.new('bash', '-c', 'foo bar.sh').to_s }
      it { is_expected.to eq('bash -c foo\ bar.sh') }
    end

    context 'without arguments' do
      subject(:command) {  described_class.new('echo $FOOBAR').to_s }
      it { is_expected.to eq('echo $FOOBAR') }
    end
  end

end
