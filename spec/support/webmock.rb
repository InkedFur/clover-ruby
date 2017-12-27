RSpec.configure do |config|
  config.before(:each) do
    webmocks = YAML.load_file 'spec/assets/webmock.yml'

    webmocks.each do |request|
      base_uri = request['base_uri'] || CLOVER_BASE_URI
      method = request['method'] || :get
      headers = request.include?('headers') ? request['headers'] : { authorization: 'Bearer notanapikey' }

      WebMock.stub_request(method.to_s.downcase.to_sym, base_uri + request['path']).
          with(headers: { accept: '*/*' }.merge(headers ||  {})).
          to_return(status: request['status'] || 200, body: request['content'], headers: { content_type: 'application/json' })
    end
  end
end

# Some Helper Methods
#
def expect_request(method=:get, path)
  expect(WebMock).to have_requested method, CLOVER_BASE_URI + path
end
