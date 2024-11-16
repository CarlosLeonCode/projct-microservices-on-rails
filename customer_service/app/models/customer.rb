# frozen_string_literal: true

class Customer < ApplicationRecord
  # Validations
  validates :customer_name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "must be a valid string" }
  validates :address, presence: true, format: { with: /\A[a-zA-Z0-9\s,]+\z/, message: "must be a valid string" }
  validates :orders_count, presence: true, numericality: { only_integer: true }
end
