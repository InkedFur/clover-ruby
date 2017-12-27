module Clover::OAuth
  # Generates the OAuth authorization URL to redirect to Clover for access.
  #
  # @param redirect_uri [String] The location on your server to redirect back
  #                              after approval. See `#handle_authorize_response`
  #
  # @return [String] The Clover OAuth Authorization URL
  #
  def self.authorize_url(redirect_uri=nil)
    redirect_uri ||= Clover.configuration.oauth_redirect_uri
    raise ArgumentError.new 'A valid redirect URI must be supplied.' if redirect_uri.nil?

    _client.auth_code.authorize_url redirect_uri: redirect_uri
  end

  # Handles the response from the `authorize_url` above.
  #
  # @param params [Hash] The URL params returned from Clover's OAuth flow.
  #                      Must have `client_id`, `code` and `merchant_id`.
  #
  # @return [Hash] A hash containing the `merchant_id` and `api_token`.
  #                You should store these!
  #
  # @example
  #
  #   class CloverApiCallbackController < ApplicationController
  #     def create
  #       response = Clover::OAuth.handle_authorize_response params
  #           #=> { merchant_id: 'abc123', api_token: 'fishsticks' }
  #
  #       # Store those in your database somewhere if you plan to make
  #       # future requests.
  #     end
  #   end
  #
  def self.handle_authorize_response(params)
    merchant_id = params[:merchant_id]
    client_id = params[:client_id]
    code = params[:code]

    if client_id != Clover.configuration.client_id
      raise ArgumentError.new 'The client_id in the response does not match ' +
                              'the current configured client_id.'
    end

    Clover.configuration.merchant_id = merchant_id

    token = get_token code

    {
        merchant_id: merchant_id,
        api_token: token
    }
  end

  # Used internally by `#handle_authorize_response` to assign the API token.
  # I suppose it can be called manually, given an authorization code.
  #
  def self.get_token(authorization_code)
    token = _client.auth_code.get_token(authorization_code).token
    Clover.configuration.api_token = token
    token
  end

  private

  def self._client
    @client ||= OAuth2::Client.new Clover.configuration.client_id,
                                   Clover.configuration.client_secret,
                                   site: Clover.configuration.oauth_authorize_uri
  end
end
