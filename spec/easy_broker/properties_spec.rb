require 'rspec'
require 'webmock/rspec'
require_relative '../../easy_broker/properties'
require_relative '../../easy_broker/client'

RSpec.describe EasyBroker::Properties do
  let(:base_url) { 'https://api.easybroker.com/v1' }
  let(:endpoint_url) { "#{base_url}/properties" }
  let(:api_key) { 'api_key' }
  let(:query_params) { { page: 1, limit: 20 } }
  let(:client) { EasyBroker::Client.new(api_key) }
  let(:properties) { EasyBroker::Properties.new(client) }
  let(:headers) { { 'Accept' => 'application/json', 'X-Authorization' => api_key } }

  describe '#all' do
    context 'when request is successful' do
      it 'returns a list of properties' do
        stub_request(:get, endpoint_url)
          .with(
            headers: headers,
            query: query_params
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

        response = properties.all(1, 20)

        expect(response).to be_an(Array)
        expect(response.first['title']).to eq('Beautiful property in Condesa 1')
        expect(response.last['title']).to eq('Beautiful property in Condesa 2')
      end
    end

    context 'when the request fails' do

      context 'with an invalid param' do
        let(:query_params) { { page: 1, limit: 'invalid' } }

        it 'returns empty array' do
          stub_request(:get, endpoint_url)
            .with(
              headers: headers,
              query: query_params
            )
            .to_return(
              status: 200,
              body: {
                content: []
              }.to_json,
              headers: { 'Content-Type' => 'application/json' }
            )

          response = properties.all(1, 'invalid' )

          expect(response).to be_an(Array)
          expect(response).to eq([])
        end
      end

      context 'with an invalid API key' do
        let(:api_key) { 'invalid_api_key' }
        it 'raises an error with the correct message' do
          stub_request(:get, endpoint_url)
            .with(headers: headers, query: query_params)
            .to_return(
              status: 401,
              body: '{"error": "Your API key is invalid"}',
              headers: { 'Content-Type' => 'application/json' }
            )

          expect { properties.all(1, 20) }.to raise_error(RuntimeError, /API Error: 401 - Your API key is invalid/)
        end
      end
    end
  end
end
