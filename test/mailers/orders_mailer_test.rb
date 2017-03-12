require 'test_helper'

class OrdersMailerTest < ActionMailer::TestCase
  test "send_order_mail" do
    mail = OrdersMailer.send_order_mail
    assert_equal "Send order mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
