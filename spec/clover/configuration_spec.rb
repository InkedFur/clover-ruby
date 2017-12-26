require 'spec_helper'

describe Clover::Configuration do
  subject { Clover::Configuration.new }

  its(:api_token) { is_expected.to be_nil }
  its(:merchant_id) { is_expected.to be_nil }

  describe 'setting values' do
    before do
      subject.api_token = 'foobar'
      subject.merchant_id = 'barbaz'
    end

    its(:api_token) { is_expected.to eq 'foobar' }
    its(:merchant_id) { is_expected.to eq 'barbaz' }
  end
end
