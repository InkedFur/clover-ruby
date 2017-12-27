def configure_clover(&block)
  before(:each) do
    return Clover.configure &block if block_given?

    Clover.configure do |config|
      config.merchant_id = 'foobar'
      config.api_token = 'notanapikey'
    end
  end
end
