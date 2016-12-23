class ShopController < ApplicationController
  def brands
    @brands = Brands.all
  end
end
