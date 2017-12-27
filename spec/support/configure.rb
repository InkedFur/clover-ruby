def configure_clover(options={}, &block)
  before(:each) do
    return Clover.configure &block if block_given?

    Clover.configure do |config|
      config.merchant_id = 'foobar'
      config.api_token = 'notanapikey'

      options.each do |k, v|
        config.send "#{k}=", v
      end
    end
  end
end
