# frozen_string_literal: true
require_dependency 'order_event_consumer'

Thread.new { OrderEventConsumer.subscribe }
