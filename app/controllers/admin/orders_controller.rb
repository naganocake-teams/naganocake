class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)

    if  order_params[:status] == "payment_confirmation"
      @order_details = @order.order_details
      @order_details.each do |order_detail|
        order_detail.update(status: 1)
      end
    end

    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
