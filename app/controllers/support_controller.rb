class SupportController < ApplicationController
  def add
    msg = Message.new message_params
    msg.user = current_user
    msg.save
    render text: 'Спасибо! Мы свяжемся с вами.'
  end

  private
  def message_params
    params.permit [:name,:email, :text]
  end
end
