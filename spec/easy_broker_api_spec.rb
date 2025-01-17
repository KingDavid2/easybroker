require 'rspec'
require 'webmock/rspec'
require_relative '../easybroker/easybroker_api.rb'

RSpec.describe EasyBrokerAPI do
  let(:base_url) { 'https://api.easybroker.com/v1' }
  let(:api_key) { 'api_key' }
  let(:client) { EasyBrokerAPI.new(api_key) }

  describe '#properties' do
    it 'fetches properties and returns a successful response' do
      stub_request(:get, "#{base_url}/properties")
        .with(
          headers: {
            'Accept' => 'application/json',
            'X-Authorization' => api_key
          },
          query: { page: 1, limit: 20 }
        )
        .to_return(
          status: 200,
          body: {
            content: [
              { title: 'Beautiful property in Condesa 1' },
              { title: 'Beautiful property in Condesa 2' }
            ]
          }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      response = client.properties(1, 20)

      expect(response.code).to eq(200)
      expect(response.parsed_response).to be_a(Hash)
      expect(response.parsed_response['content']).to be_an(Array)
      expect(response.parsed_response['content'].first['title']).to eq('Beautiful property in Condesa 1')
      expect(response.parsed_response['content'].last['title']).to eq('Beautiful property in Condesa 2')
    end

    it 'returns an error response for an invalid API key' do
      stub_request(:get, "#{base_url}/properties")
        .with(
          headers: {
            'Accept' => 'application/json',
            'X-Authorization' => api_key
          },
          query: { page: 1, limit: 20 }
        )
        .to_return(
          status: 401,
          body: { error: 'Your API key is invalid' }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      # Ejecución del método
      response = client.properties(1, 20)

      expect(response.code).to eq(401)
      expect(response.parsed_response).to be_a(Hash)
      expect(response.parsed_response['error']).to eq('Your API key is invalid')
    end
  end
end
