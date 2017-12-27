class Clover::Authentication < Faraday::Middleware
  def call(env)
    env[:request_headers]['Authorization'] = "Bearer #{Clover.configuration.api_token}"
    @app.call(env)
  end
end
