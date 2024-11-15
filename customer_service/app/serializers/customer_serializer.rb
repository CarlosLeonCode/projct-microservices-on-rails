# frozen_string_literal: true

class CustomerSerializer < ActiveModel::Serializer
  attributes :customer_name, :address, :orders_count
end
