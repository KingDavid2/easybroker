# frozen_string_literal: true

require_relative 'client'

module EasyBroker
  class Properties
    def initialize(client)
      @client = client
    end

    def all(page = 1, limit = 20)
      response = @client.get('/properties', { page: page, limit: limit })
      handle_response(response)
    end

    def find(id)
      response = @client.get("/properties/#{id}")
      handle_response(response)
    end

    private

    def handle_response(response)
      case response.code
      when 200
        response.parsed_response['content']
      else
        error_message = response.parsed_response['error'] || response.message
        raise "API Error: #{response.code} - #{error_message}"
      end
    end
  end
end
