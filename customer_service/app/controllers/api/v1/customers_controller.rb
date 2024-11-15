class Api::V1::CustomersController < ApplicationController
  include Response

  def show
    json_response(customer)
  end

  private
  def customer
    @customer ||= Customer.find(params[:id])
  end
end
