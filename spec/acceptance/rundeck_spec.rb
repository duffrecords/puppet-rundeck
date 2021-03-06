require 'spec_helper_acceptance'

describe 'rundeck class' do
  context 'default parameters' do
    it 'applies successfully' do
      pp = <<-EOS
      class { 'java':
        distribution => 'jre'
      }
      class { 'rundeck': }

      Class['java'] -> Class['rundeck']
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('rundeck') do
      it { is_expected.to be_installed }
    end

    describe service('rundeckd') do
      it { is_expected.to be_running }
    end
  end
end
