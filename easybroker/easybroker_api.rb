require 'httparty'
require 'dotenv/load'

class EasyBrokerAPI
  include HTTParty
  base_uri 'https://api.easybroker.com/v1'

  def initialize(api_key = ENV['API_KEY'])
    @headers = {
      'Accept' => 'application/json',
      'X-Authorization' => api_key
    }
  end

  def properties(page = 1, limit = 20)
    self.class.get('/properties', headers: @headers, query: { page: page, limit: limit })
  end
end
