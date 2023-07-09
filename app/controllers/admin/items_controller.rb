class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if  @item.save
      redirect_to admin_items_path, notice: "You have created item successfully."
    else
      render new_admin_item_path
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render edit_admin_item_path(@item)
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to admin_items_path
    else
      render admin_item_path(@item)
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,:description,:price,:genre_id, :item_image, :sale_status)
  end
end
