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

  private

  def order_item_params
    {
        quantity: params[:quantity],
        item_id: params[:id]
    }
  end
end