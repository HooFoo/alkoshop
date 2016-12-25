class ShopController < ApplicationController
  def brands
    @brands = Brand.all
  end

  def template
    if params[:brand]
      @brand = Brand.find_by_name params[:brand]
    end
    super
  end
end
