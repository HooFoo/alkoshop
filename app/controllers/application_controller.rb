class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user
  before_action :set_special
  before_action :current_order
  before_action :set_discount
  before_action :cart_items
  before_action :set_about

  protected

  def template
    render template: "templates/#{params[:name]}",layout: false
  end


  def set_user
    @user = current_user || User.new
  end

  def set_special
    @specials = Special.all
  end

  def cart_items
    @order_items = current_order.order_items
  end

  def current_order
    if !session[:order_id].nil?
      begin
        @order = Order.find(session[:order_id])
      rescue ActiveRecord::RecordNotFound => ex
        @order = Order.new
      end
      if @order.user.nil? && !current_user.nil?
        @order.user = current_user
        @order.save
      end
    else
      if @order.nil?
        @order = Order.new user: current_user
        @order.save
      end
      session[:order_id] = @order.id
    end
    @order
  end

  def set_about
    @about = News.where(title: 'О проекте').first
  end

  def set_discount
    if @order.nil?
      @discount = 0
      @discount_card_number = ''
      @discount_multiplier = 1
    else
      @discount = @order.user&.discount_card ? @order.user.discount_card.discount : 0
      @discount_card_number = @order.user&.discount_card ? @order.user.discount_card.number : ''
      @discount_multiplier = 1.0 - @discount / 100.0
    end
  end
end
