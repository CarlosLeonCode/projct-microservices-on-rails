# frozen_string_literal: true
require 'faker'

FactoryBot.define do
  factory :order do
    product_name { Faker::Name.name }
    quantity { rand(1..3) }
    price { Faker::Number.decimal(l_digits: 3, r_digits: 3) }
    status { Order.statuses["created"] }
    customer_id { rand(1..10) }
  end
end
