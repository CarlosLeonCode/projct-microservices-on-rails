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
      response.body
    end
  end
end

