if Customer.all.length == 0
  10.times do
    Customer.create(
      customer_name: Faker::Artist.name,
      address: Faker::Address.street_address,
      orders_count: Faker::Number.digit
    )
  end
  puts "Customer seeds executed!"
else
  puts "Customer seeds not executed, table with data"
end
