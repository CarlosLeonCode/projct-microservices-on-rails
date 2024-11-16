# frozen_string_literal: true

class Api::V1::CustomersController < ApplicationController
  include Response

  def show
    json_response(response: CustomerSerializer.new(customer), message: "success")
  end

  private

  def customer
    @customer ||= Customer.find(params[:id])
  end
end
