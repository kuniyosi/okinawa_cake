class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    # mewで送られてきたselect_addressが０の場合の処理
    if params[:order][:select_address] == "0"
      @order.postcode = current_customer.postal_code
      @order.ship_to_address = current_customer.address
      @order.ship_name = current_customer.full_name
    elsif params[:order][:select_address] == "1"
      @address = Delivery.find(params[:order][:address_id])
      @order.postcode = @address.postcode
      @order.ship_to_address = @address.address
      @order.ship_name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.customer_id = current_customer.id
    end
    @cart_items = current_customer.cart_items
    render :confirm
  end

  # 注文確定処理
  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items
    # order_detailテーブルに商品を一個ずつ取り出して保存する。
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      # 注文詳細がどの注文に結びついているか
      @order_details.order_id = @order.id
      @order_details.item_id = cart_item.item.id
      @order_details.item_price = cart_item.item.add_tax_price
      @order_details.quantity = cart_item.item_quantity
      # 制作ステータスを初期値の0で送る
      @order_details.production_status = 0
      @order_details.save!
    end
    # カート内を全て削除するため
    CartItem.destroy_all
    redirect_to thanks_path
  end

  def thanks
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postcode, :ship_to_address, :ship_name, :customer_id , :status, :freight, :total_price)
  end

  def address_params
    params.require(:order).permit(:ship_name, :ship_to_address)
  end

end
