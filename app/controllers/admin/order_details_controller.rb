class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(params[:order_id])
    @order_detail.update(order_detail_params)

    if order_detail_params[:status] == "in_production"
      @order.update(status: 2)
    elsif @order.order_details.where(status: "completion_of_production").count == @order.order_details.count
      @order.update(status: 3)
    end
    redirect_to  admin_order_path(params[:order_id])
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:status)
  end
end
