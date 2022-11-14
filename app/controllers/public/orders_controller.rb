class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.order.all
  end

  def show
  end

  def confirm

    if params[:order][:select_address] == "0"
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name

    elsif params[:order][:select_address] == "1"
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    else
      @order = Order.new(order_params)
    end
    binding.pry
    #@order.save
    #redirect_to orders_path
  end

  def create
    @order = Order.new(order_params)
    @order.total_payment = params[:order][:total_payment]
    @order.shipping_cost = 800
    @order.save
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment, :customer_id)
  end

end
