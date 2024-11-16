# frozen_string_literal: true

class Order < ApplicationRecord
  enum :status, { "created": 0, "preparing": 1, "delivered": 2 }

  validates :product_name, :quantity, :price, :customer_id, :status, presence: true
  validates :quantity, :customer_id, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :price, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: statuses.keys, message: "%{value} is not a valid status" }
end
