class Public::DeliveriesController < ApplicationController
  before_action :authenticate_customer!

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
      redirect_to deliveries_path, notice: "You have updated delivery successfully."
    else
      render :edit
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    if  @delivery.destroy
      redirect_to deliveries_path, notice: "Deleted successfully"
    else
      render :index
    end
  end

  private

  def delivery_params
    params.require(:delivery).permit(:name, :address, :postcode)
  end

end
