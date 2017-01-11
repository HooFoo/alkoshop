class FrontendController < ApplicationController
  layout proc{|c| c.request.xhr? ? false : 'application' }

  def index

  end

  def profile

  end

  def shop
    @item = Item.promoted
  end

  def template
    if params[:news]
      @news = News.find params[:news]
    end
    super
  end

  def orders
    @orders = current_user.orders.joins(:order_state).where('order_states.name':'Finished')
  end

  def contacts

  end

  def news
    @news = News.all
  end
end
