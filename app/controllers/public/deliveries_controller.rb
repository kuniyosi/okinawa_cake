class Public::DeliveriesController < ApplicationController

  def index
    @delivery_new = Delivery.new
    @customer = current_customer
    @deliveries = @customer.deliveries
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      redirect_to deliveries_path
    else
      @deliveries = Delivery.all
      render :index
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to edit_delivery_path(@delivery), notice: "You have updated delivery successfully."
    else
      render :edit
    end
  end

  private

  def delivery_params
    params.require(:delivery).permit(:name, :address, :postcode)
  end

end
