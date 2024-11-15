class Api::V1::OrdersController < ApplicationController
  include Response

  def index
    json_response(Order.all)
  end

  def show
    json_response(order)
  end

  def show_by_customer
  end

  def create
    # order = Order.create!(order_params)    
    # json_response(order, status: :created)
    print "-----"
        
    sd = CustomerApiService.get_resource(endpoint: '/customers')
    
    binding.pry
    
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
