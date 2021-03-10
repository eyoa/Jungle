class ReceiptMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def receipt_email(order)

    @user = User.find_by(email: order.email)
    if !@user
      @user = User.first
    end
    
    @order = order

    mail(to: @order.email, subject: "Order##{@order.id} has been received")

  end
end
