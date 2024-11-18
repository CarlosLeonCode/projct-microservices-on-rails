# frozen_string_literal: true
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
      if @connection.nil? || !@connection.open?
        @connection = connection
      end
      Thread.current[:rabbitmq_channel] ||= connection.create_channel
    end

    def exchange
      @exchange ||= channel.topic('order_events', durable: true)
    end
  end
end
