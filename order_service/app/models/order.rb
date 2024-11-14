class Order < ApplicationRecord
  after_create :publish_order_created_event

  private

  def publish_order_created_event
    order_data = { customer_id: customer_id, order_id: id, total: total }
    RabbitMQ.order_exchange.publish(order_data.to_json, routing_key: 'order.created')
  end
end
