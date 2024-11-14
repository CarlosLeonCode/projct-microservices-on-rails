require 'bunny'

class RabbitMQ
  def self.connection
    @connection ||= Bunny.new(hostname: 'localhost').tap(&:start)
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.order_exchange
    @order_exchange ||= channel.direct('orders_exchange', durable: true)
  end
end
