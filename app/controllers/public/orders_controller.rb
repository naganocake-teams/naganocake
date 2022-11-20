class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def complete
  end

  def confirm
    @cart_items = current_customer.cart_items
    @sum = 0

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
    @order.shipping_cost = 800
  end

  def create
    @order = Order.new(order_params)
    @order.save

    current_customer.cart_items.each do |cart_items|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_items.item_id
      @order_detail.order_id = @order.id
      @order_detail.price = cart_items.item.with_tax_price
      @order_detail.amount = cart_items.amount
      @order_detail.save
    end

    current_customer.cart_items.destroy_all

    redirect_to order_complete_path
  end


  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment, :customer_id, :shipping_cost, :customer_id)
  end

  #def order_detail_params
   # params.require(:order_detail).permit(:order_id, :item_id, :price, :amount)
  #end

end
