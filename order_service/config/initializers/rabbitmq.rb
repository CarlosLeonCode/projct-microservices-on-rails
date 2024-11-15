require 'bunny'

module RabbitMQ
  # Using module as singleton, defining static methods
  class << self
    def connection
      @connection ||= Bunny.new(
        host: ENV['RABBITMQ_HOST'],
        port: ENV['RABBITMQ_PORT'],
        user: ENV['RABBITMQ_USER'],
        password: ENV['RABBITMQ_PASSWORD'],
        vhost: ENV['RABBITMQ_VHOST']
      ).start
    end
  
    def channel
      Thread.current[:rabbitmq_channel] ||= connection.create_channel
    end
  end
end
