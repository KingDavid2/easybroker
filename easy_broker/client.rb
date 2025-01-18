# frozen_string_literal: true

require 'httparty'

module EasyBroker
  class Client
    include HTTParty
    base_uri 'https://api.easybroker.com/v1'

    def initialize(api_key = ENV['API_KEY'])
      @headers = {
        'Accept' => 'application/json',
        'X-Authorization' => api_key
      }
    end

    def get(path, query = {})
      self.class.get("#{@base_uri}#{path}", headers: @headers, query: query)
    end
  end
end
