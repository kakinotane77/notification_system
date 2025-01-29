class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      NotificationService.send_notification(@customer)
      flash[:notice] = "お問い合わせを受け付けました。"
      redirect_to thank_you_path
    else
      flash[:alert] = "入力内容に誤りがあります。"
      render :new, status: :unprocessable_entity
    end
  end

  def thank_you
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :phone, :email)
  end
end
