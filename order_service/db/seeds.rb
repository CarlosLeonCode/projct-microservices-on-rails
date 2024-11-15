if Order.all.length === 0
  10.times do
    Order.create(
      product_name: Faker::Device.manufacturer,
      quantity: rand(1..10),
      price: 20.000,
      status: Order.statuses["ordered"],
      customer_id: rand(1..3) 
    )
  end
  puts("Orders created")
else
  puts("Orders with data")
end
