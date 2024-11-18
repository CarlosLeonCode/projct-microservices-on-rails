# frozen_string_literal: true
require 'rails_helper'

RSpec.describe OrderEventConsumer do
  describe '.subscribe' do
    let(:mock_connection) { double('Bunny::Session') }
    let(:mock_channel) { double('Bunny::Channel') }
    let(:mock_queue) { double('Bunny::Queue') }
    let(:mock_delivery_info) { double('DeliveryInfo', delivery_tag: 'tag_123') }
    let(:mock_payload) { { 'customer_id' => 1 }.to_json }
    let(:mock_customer) { instance_double(Customer, id: 1, orders_count: 5) }

    before do
      allow(RabbitMQ).to receive(:connection).and_return(mock_connection)
      allow(mock_connection).to receive(:create_channel).and_return(mock_channel)
      allow(RabbitMQ).to receive(:channel).and_return(mock_channel)
      allow(mock_channel).to receive(:queue).and_return(mock_queue)
      allow(mock_channel).to receive(:ack)
      allow(mock_channel).to receive(:nack)
      allow(mock_queue).to receive(:bind)
      allow(mock_queue).to receive(:subscribe).and_yield(mock_delivery_info, nil, mock_payload)
    end

    context 'when the customer exists' do
      it 'increments the orders_count' do
        allow(Customer).to receive(:find_by).with(id: 1).and_return(mock_customer)
        allow(mock_customer).to receive(:increment!)

        OrderEventConsumer.subscribe

        expect(mock_customer).to have_received(:increment!).with(:orders_count)
        expect(mock_channel).to have_received(:ack).with('tag_123')
      end
    end
  end
end
