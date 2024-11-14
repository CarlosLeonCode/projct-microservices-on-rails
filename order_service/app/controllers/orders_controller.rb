class OrdersController < ApplicationController
  def create
    order = Order.new(order_params)
    if order.save
      render json: { message: 'Order created successfully' }, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :total)
  end
end
