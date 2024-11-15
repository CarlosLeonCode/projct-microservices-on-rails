# frozen_string_literal: true

class Api::V1::OrdersController < ApplicationController
  include Response

  def index
    json_response(Order.all)
  end

  def show
    json_response(order)
  end

  def create
    interactor = CreateOrder.call(
      order_params: order_params,
      customer_id: params[:customer_id]
    )
    
    json_response(
      response: { order: OrderSerializer.new(interactor.response[:order]), customer: interactor.response[:customer] },
      message: "Order created!",
      status: :created
    )
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

  def order
    @order ||= if params[:customer_id].present?
                Order.where(customer_id: params[:customer_id]) 
              else 
                Order.find(params[:id])
              end
  end
end
