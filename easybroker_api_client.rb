require 'httparty'
require 'dotenv/load'

class EasyBrokerAPI
  include HTTParty
  base_uri ENV['EASYBROKER_API_BASE_URL']

  def initialize
    @headers = {
      'Content-Type' => 'application/json',
      'X-Authorization' => ENV['API_KEY']
    }
  end

  private

  def handle_response(response)
    case response.code
    when 200
      response.parsed_response['content']
    else
      raise "API Error: #{response.code} - #{response.message}"
    end
  end
end
