require 'bunny'

class RabbitMQ
  def self.connection
    @connection ||= Bunny.new(hostname: 'localhost').tap(&:start)
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.order_queue
    @order_queue ||= channel.queue('orders_queue', durable: true)
  end

  def self.bind_queue
    exchange = channel.direct('orders_exchange', durable: true)
    order_queue.bind(exchange, routing_key: 'order.created')
  end
end
