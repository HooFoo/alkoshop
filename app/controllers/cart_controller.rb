class CartController < ApplicationController

  before_action :order_item_params

  layout false

  def add
    @order = current_order
    @order_item = @order.order_items.where(item_id: params[:id]).first
    if @order_item.nil?
      @order_item = @order.order_items.new({order: @order}.merge order_item_params)
    else
      @order_item.quantity = params[:quantity].to_i
    end
    begin
      item_volume = ItemsVolume.find(params[:price_id])
    rescue ActiveRecord::RecordNotFound => e
      item_volume = @order_item.item.items_volumes.first
    ensure
      @order_item.unit_price = item_volume.price
      @order_item.volume = item_volume.volume
    end
    @order_item.save
    session[:order_id] = @order.id
    @order_items = current_order.order_items
    render template: 'cart/show'
  end

  def remove
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    render template: 'cart/show'
  end

  def show
  end

  def complete
    if (user = current_user)
      @address = user.orders.last.address unless user.orders.last.nil?
      if @order.order_items.size > 0
        render 'complete', layout: 'application'
      else
        redirect_to '/shop/catalog'
      end
    else
      redirect_to '/profile/registration'
    end
  end

  def finish
    if @order.complete! params[:adress], params[:delivery]
      @order = Order.create
      session[:order_id] = @order.id
      redirect_to '/profile/orders'
    else
      render partial: 'shared/empty_order'
    end
  end

  def repeat
    @order = Order.find(params[:id]).dup
    @order.order_items = Order.find(params[:id]).order_items
    @order.order_state  = OrderState.where(name: 'In progress').first_or_create!
    if @order.save
      session[:order_id] = @order.id
    end
    redirect_to '/cart/complete'
  end

  private

  def order_item_params
    {
        quantity: params[:quantity] || 1,
        item_id: params[:id]
    }
  end
end
