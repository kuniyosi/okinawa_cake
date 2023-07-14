class Public::HomesController < ApplicationController

  def top
    # per(4)とすることでitemを４つずつで表示
    @items = Item.all.page(params[:page]).per(4)
  end

  def about
  end
end
