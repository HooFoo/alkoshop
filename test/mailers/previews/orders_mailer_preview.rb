# Preview all emails at http://localhost:3000/rails/mailers/orders_mailer
class OrdersMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/orders_mailer/send_order_mail
  def send_order_mail
    OrdersMailer.send_order_mail
  end

end
