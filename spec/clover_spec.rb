require "spec_helper"

RSpec.describe Clover do
  it "has a version number" do
    expect(Clover::VERSION).to_not be nil
  end

  describe '#configure' do
    before do
      Clover.configure do |config|
        config.merchant_id = 'foobar'
        config.api_token = 'notarealapikey'
      end
    end

    subject { Clover.configuration }

    its(:merchant_id) { is_expected.to eq 'foobar' }
    its(:api_token) { is_expected.to eq 'notarealapikey' }
  end
end
