class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
  end

  # 注文確定処理
  def create
    @order = orders.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items
    # order_detailテーブルに商品を一個ずつ取り出して保存する。
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      # 注文詳細がどの注文に結びついているか
      @order_details.order_id = @order.id
      @order_details.item_id = cart_item.item.id
      @order_details.item_price = cart_item.item.add_tax_price
      @order_details.number = cart_item.quantity
      # 制作ステータスを初期値の0で送る
      @order_details.production_status = 0
      @order_details.save!
    end
    # カート内を全て削除するため
    CartItem.destroy_all
    redirect_to order_thanks_path
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit()
  end

end
