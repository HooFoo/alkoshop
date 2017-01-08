class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user
  before_action :current_order
  before_action :cart_items

  protected

  def template
    render template: "templates/#{params[:name]}",layout: false
  end


  def set_user
    @user = current_user || User.new
  end

  def cart_items
    @order_items = current_order.order_items
  end

  def current_order
    if !session[:order_id].nil?
      @order = Order.find(session[:order_id])
    else
      @order = Order.new user: current_user
      @order.save
    end
    @order
  end
end
