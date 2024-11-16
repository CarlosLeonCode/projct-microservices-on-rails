class Customer < ApplicationRecord
  validates :customer_name, presence: true
end
