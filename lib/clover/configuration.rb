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

    # TODO - move the above into a getter that switches on @mode ['production', 'sandbox']
    # @api_endpoint = ENV['CLOVER_API_ENDPOINT']
    # @oauth_authorize_uri = ENV['CLOVER_OAUTH_AUTHORIZE_URI']

    @api_token = ENV['CLOVER_API_TOKEN']
    @merchant_id = ENV['CLOVER_MERCHANT_ID']
    @client_id = ENV['CLOVER_CLIENT_ID']
    @client_secret = ENV['CLOVER_CLIENT_SECRET']
    @oauth_redirect_uri = ENV['CLOVER_OAUTH_REDIRECT_URI']
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
