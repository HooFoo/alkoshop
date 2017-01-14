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
    if current_user
      @orders = current_user.orders.joins(:order_state).where('order_states.name':'Finished')
    else
      redirect_to '/profile'
    end
  end


  def contacts

  end

  def news
    @news = News.all
  end
end
