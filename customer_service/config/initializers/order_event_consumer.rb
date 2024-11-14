Thread.new do
  RabbitMQ.order_queue.subscribe(block: true) do |delivery_info, _properties, payload|
    order_data = JSON.parse(payload)

    # Encuentra el cliente por ID y actualiza el contador de pedidos
    customer = Customer.find_by(id: order_data['customer_id'])
    if customer
      customer.increment!(:orders_count)
    else
      Rails.logger.warn("Customer not found with ID #{order_data['customer_id']}")
    end
  end
end
