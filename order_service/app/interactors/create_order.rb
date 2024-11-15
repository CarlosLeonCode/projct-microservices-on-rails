# frozen_string_literal: true

=begin
Using Interactor Gem to handle business Logic in a 
clean, organized and maintainable way. Using SRP and DIP from SOLID.

Using interactors, you can decouple the business logic from the controllers 
and models, following DIP by making higher-level modules 
(e.g., controllers) less dependent on lower-level details.
=end
class CreateOrder
  include Interactor

  def call
    context.response = { 
      order: create_order, 
      customer: fetch_customer 
    }
  end

  private

  def create_order
    Order.create!(context.order_params)
  end

  def fetch_customer
    CustomerApiService.get_resource(endpoint: "customers/#{context.customer_id}")["response"]
  rescue Faraday::ConnectionFailed
    Rails.logger.warn("Customer service Connection Failed")
    nil
  end
end
