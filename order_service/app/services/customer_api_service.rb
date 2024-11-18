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
      Rails.logger.info "Services - CustomerApiService: Calling external service #{connection.url_prefix + endpoint}"
      response = connection.get(endpoint, params)
      if response.success?
        JSON.parse response.body
      else
        Rails.logger.warn "Services - CustomerApiService: Error #{response.status} - #{response.body}"
        nil
      end
    end
=begin
    Here can go more methods like:
    -> set_resouce
    -> update_resource
    etc..
=end
  end
end

