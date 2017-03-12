class OrdersMailer < ApplicationMailer
  default from: 'orders@stashstore.ru'
  def send_order_mail(ord)
    @order = ord
    @user = ord.user
    @url  = "http://stashstore.ru/admin/orders/#{ord.id}"
    mail(to: ENV['ORD_MAIL'], subject: 'Новый заказ на сайте stashstore.ru')
  end
end
