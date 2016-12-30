class ShopController < ApplicationController

  Sorts = {
      'Сначала новые': :created_at,
      'Сначала старые': :created_at,
      'Сначала премиальные': :price,
      'Сначала бюджетные': :price,
  }

  def brands
    @brands = Brand.all
  end

  def catalog
    @filters = prepare_filters
    @items = Item.all
  end

  def template
    if params[:brand]
      @brand = Brand.find_by_name params[:brand]
    end
    if params[:item]
      @item = Item.find params[:item]
      @same = Item.same @item
    end
    super
  end

  private

  def prepare_filters
    {
        brands: Brand.cached_all,
        types: Type.cached_all,
        countries: Country.cached_all,
        sort: Sorts
    }
  end
end
