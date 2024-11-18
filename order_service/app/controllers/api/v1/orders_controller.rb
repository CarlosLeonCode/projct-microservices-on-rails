# frozen_string_literal: true

class Api::V1::OrdersController < ApplicationController
  include Response

  def index
    serialized_orders = serialize_collection(Order.all, OrderSerializer)
    json_response(response: serialized_orders, message: "success")
  end

  def show
    json_response(response: OrderSerializer.new(order), message: "success")
  end

  def create
    interactor = CreateOrder.call(
      order_params: order_params,
      customer_id: params[:order][:customer_id]
    )
    
    json_response(
      response: { 
        order: OrderSerializer.new(interactor.response[:order]), 
        customer: interactor.response[:customer] 
      },
      message: "Order created!",
      status: :created
    )
  rescue CustomerNotFound => e
    Rails.logger.warn("Caught error: #{e}")
    json_response(
      response: nil,
      message: e,
      status: :not_found
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
