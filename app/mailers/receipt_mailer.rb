class ReceiptMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def receipt_email(order)
    # raise order.inspect
    # @user = User.find_by(email: order.email)
    @user = User.first
    
    @order = order

    mail(to: @order.email, subject: "Order##{@order.id} has been received")

  end
end
