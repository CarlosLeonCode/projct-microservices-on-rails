# frozen_string_literal: true

class CustomerApiService
  class << self
    def connection
      Faraday.new(
        url: ENV['CUSTOMER_SERVICE_API_PATH'],
        headers: {'Content-Type' => 'application/json'}
      )
    end

    def get_resource(endpoint:, params: {})
      response = connection.get(endpoint, params)
      raise "Error: #{response.status} - #{response.body}" unless response.success?
      
      JSON.parse response.body
    end
=begin
    Here can go more methods like:
    -> set_resouce
    -> update_resource
    etc..
=end
  end
end

