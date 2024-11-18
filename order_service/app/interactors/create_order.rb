# frozen_string_literal: true

=begin
Using Interactor Gem to handle business Logic in a 
clean, organized and maintainable way. Using SRP and DIP from SOLID.

Using interactors, you can decouple the business logic from the controllers 
and models, following DIP by making higher-level modules 
(e.g., controllers) less dependent on lower-level details.
=end

# Create order if customer services found a customer,
# then update orders_count emiting a rabbitMQ event
class CreateOrder
  include Interactor

  def call
    customer = fetch_customer
    if customer
      context.response = { 
        order: create_order, 
        customer: fetch_customer 
      }
      emit_event
    else
      raise CustomerNotFound
    end    
  end

  private

  def create_order
    Order.create!(context.order_params)
  end

  def fetch_customer
    @customer ||= CustomerApiService.get_resource(endpoint: "customers/#{context.customer_id}")
  rescue Faraday::ConnectionFailed
    Rails.logger.warn("Customer service Connection Failed")
    nil
  end

  def emit_event
    OrderEventProducer.publish('created', { customer_id: context.customer_id })
  end
end
