# frozen_string_literal: true

class OrderEventConsumer
  class << self
    def subscribe
      connection = RabbitMQ.connection
      channel = connection.create_channel
      queue = channel.queue('customer_service_queue', durable: true)
      queue.bind(RabbitMQ.exchange, routing_key: 'order.created')

      queue.subscribe(manual_ack: true) do |delivery_info, _properties, payload|
        begin
          Rails.logger.info("Consumers - OrderEventConsumer: Processing delivery info")
          process_event(JSON.parse(payload))
          channel.ack(delivery_info.delivery_tag)
        rescue StandardError => e
          Rails.logger.error("Consumers - OrderEventConsumer: Error processing event: #{e.message}")
          channel.nack(delivery_info.delivery_tag, false, true)
        end
      end
    rescue Bunny::Exception => e
      Rails.logger.error("Consumers - OrderEventConsumer: RabbitMQ connection error: #{e.message}")
    end

    def process_event(data)
      customer = Customer.find_by(id: data['customer_id'])
      if customer
        old_orders_count = customer.orders_count
        customer.increment!(:orders_count)
        Rails.logger.info("Consumers - OrderEventConsumer: Updated orders_count for customer ##{customer.id} with orders_count from #{old_orders_count} to #{customer.orders_count}")
      else
        Rails.logger.warn("Consumers - OrderEventConsumer: Customer not found: #{data['customer_id']}")
      end
    end
  end
end
