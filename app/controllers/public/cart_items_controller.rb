class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_items = current_customer.cart_items.new(cart_item_params)
    # 商品がすでにカート内にある時の処理
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      # 同じ商品があった場合、別々の処理ではなく個数を合算して処理をする
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      # 元々カート内にあった商品の個数に新しくカート内に入れた商品の個数を数値として合算する
      cart_item.item_quantity += params[:cart_item][:item_quantity].to_i
      cart_item.save
      redirect_to cart_items_path
    # 同じ商品がなければ通常の処理
    elsif @cart_items.save
        @cart_items = current_customer.cart_items
        render 'index'
    # 保存できなかった場合の処理
    else
      render :index
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = CartItem.all
    cart_items.destroy_all
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :item_quantity)
  end
end
