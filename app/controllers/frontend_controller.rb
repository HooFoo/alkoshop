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
    super
  end

  def orders

  end
end
