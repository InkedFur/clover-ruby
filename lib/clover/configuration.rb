class Clover::Configuration
  attr_accessor :api_token
  attr_accessor :merchant_id
  attr_accessor :api_endpoint
  attr_writer :her_api

  def initialize
    @api_endpoint = 'https://apisandbox.dev.clover.com'
  end

  def her_api
    @her_api ||= _default_her_api
  end

  private

  def _default_her_api
    api = Her::API.new

    api.setup url: self.api_endpoint do |c|
      c.use Clover::Authentication
      c.use Faraday::Request::UrlEncoded

      c.use Her::Middleware::DefaultParseJSON

      c.use Faraday::Adapter::NetHttp
    end
  end
end
