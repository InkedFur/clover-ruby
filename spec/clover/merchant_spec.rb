require 'spec_helper'

describe Clover::Merchant do
  configure_clover

  describe 'all' do
    it 'makes an API call' do
      merchants = Clover::Merchant.all

      expect(merchants).to be_a Array
      expect(merchants.first).to be_a Clover::Merchant
      expect(merchants.length).to eq 2

      expect_request '/merchants'
    end
  end

  describe 'find' do
    it 'finds merchant foobar' do
      merchant = Clover::Merchant.find 'foobar'

      expect(merchant).to be_a Clover::Merchant
      expect(merchant.name).to eq 'Foo Bar, Inc.'

      expect_request '/merchants/foobar'
    end
  end

  describe 'current' do
    configure_clover merchant_id: 'foobar'

    context 'without merchant_id config' do
      configure_clover merchant_id: nil

      it 'explodes gracefully' do
        expect { Clover::Merchant.current }.to raise_exception ArgumentError
      end
    end

    it 'finds current merchant' do
      merchant = Clover::Merchant.current

      expect(merchant).to be_a Clover::Merchant
      expect(merchant.name).to eq 'Foo Bar, Inc.'

      expect_request '/merchants/foobar'
    end
  end

  describe 'new' do
    it 'finds merchant foobar' do
      merchant = Clover::Merchant.find 'foobar'
      merchant.name = 'Updated Foobar'
      merchant.save

      expect_request :post, '/merchants/foobar'
    end
  end
end
