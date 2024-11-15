class OrderSerializer < ActiveModel::Serializer
  attributes :id, :product_name, :quantity, :price, :status, :customer_id
end
