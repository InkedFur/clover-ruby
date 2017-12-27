class Clover::Configuration
  attr_accessor :api_token
  attr_accessor :merchant_id
  attr_accessor :api_endpoint
  attr_accessor :client_id
  attr_accessor :client_secret

  attr_accessor :oauth_authorize_uri
  attr_accessor :oauth_redirect_uri

  attr_writer :her_api

  def initialize
    @api_endpoint = 'https://apisandbox.dev.clover.com'
    @oauth_authorize_uri = 'https://sandbox.dev.clover.com/oauth/authorize'
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
