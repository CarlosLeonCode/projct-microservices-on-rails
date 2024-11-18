class OrderEventProducer
  class << self
    def publish(event_type, payload)
      RabbitMQ.exchange.publish(
        payload.to_json,
        routing_key: "order.#{event_type}",
        persistent: true
      )
    end
  end
end
