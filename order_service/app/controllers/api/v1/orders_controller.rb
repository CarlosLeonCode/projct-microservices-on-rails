class Api::V1::OrdersController < ApplicationController
  include Response

  def show
    json_response(Order.all)
  end

  def create
    order = Order.create!(order_params)    
    json_response(order, status: :created)
  end

  private

  def order_params    
    params.require(:order).permit(
      :customer_id, 
      :product_name, 
      :customer_id, 
      :quantity, 
      :price, 
      :status
    )
  end
end
