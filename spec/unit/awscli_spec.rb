require 'spec_helper'

describe 'awscli', :type => :class do

  context 'on unsupported OS' do
    let(:facts) do
      {
        :osfamily => 'fuuuu'
      }
    end

    it 'should completely fail' do
      expect { subject }.to raise_error(Puppet::Error,/unsupported osfamily \"fuuuu\"/)
    end
  end


  context 'on redhat/centos' do
    let(:facts) do
      {
        :osfamily => 'redhat'
      }
    end

    context 'with epel enabled' do
      let(:params) do
        {
          :enable_epel => true
        }
      end

      it 'should include epel' do
        should include_class('epel')
      end
    end

    context 'with epel disabled' do
      let(:params) do
        {
          :enable_epel => false
        }
      end

      it 'should not include epel' do
        should_not include_class('epel')
      end
    end

    it 'should install pip' do
      should contain_package('python-pip').with_ensure('installed')
    end
    it 'should install awscli via pip' do
      should contain_package('awscli').with({
        :ensure   => 'installed',
        :provider => 'pip'
      })
    end
  end

  context 'on ubuntu/debian' do
    let(:facts) do
      {
        :osfamily => 'debian'
      }
    end

    it 'should not include epel' do
      should_not include_class('epel')
    end

    it 'should install pip' do
      should contain_package('python-pip').with_ensure('installed')
    end
    it 'should install awscli via pip' do
      should contain_package('awscli').with({
        :ensure   => 'installed',
        :provider => 'pip'
      })
    end
  end
end
