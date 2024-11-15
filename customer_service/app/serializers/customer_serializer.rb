class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :customer_name, :address, :orders_count
end
