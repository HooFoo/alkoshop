class ShopController < ApplicationController
  def brands
    @brands = Brand.all
  end
end
