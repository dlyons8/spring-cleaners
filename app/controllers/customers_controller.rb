class CustomersController < ApplicationController
  skip_before_action :require_login

  def new
    @customer = Customer.new
  end

  def create
    @customer = current_user.build_customer(customer_params)
    if @customer.save
      flash[:notice] = "Thanks for signing up!"
      redirect_to customer_path(@customer)
    else
      render :new
      flash[:alert] = "Your registration could not be completed"
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :phone, :whatsapp, address: [:street_address, :neighborhood, :city])
  end
end
