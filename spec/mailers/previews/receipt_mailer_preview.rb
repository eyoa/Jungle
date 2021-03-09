# Preview all emails at http://localhost:3000/rails/mailers/receipt_mailer
class ReceiptMailerPreview < ActionMailer::Preview
  def receipt_mail_preview
    ReceiptMailer.receipt_email(Order.first)
  end
end
