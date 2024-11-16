# frozen_string_literal: true
require 'faker'

FactoryBot.define do
  factory :customer do
    customer_name { Faker::Artist.name }
    address { Faker::Address.street_address }
    orders_count { rand(1..10) }
  end
end
