require 'httparty'
require 'dotenv/load'

require_relative './easy_broker/client'
require_relative './easy_broker/properties'

module EasyBroker
  def self.client
    EasyBroker::Client.new
  end

  def self.properties
    EasyBroker::Properties.new(client)
  end
end
