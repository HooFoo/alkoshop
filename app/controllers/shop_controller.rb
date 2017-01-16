class ShopController < ApplicationController

  Sorts = {
      'Сначала новые': 'created_at ASC',
      'Сначала старые': 'created_at DESC',
      'Сначала премиальные': 'price DESC',
      'Сначала бюджетные': 'price ASC',
  }

  def brands
    @brands = Brand.all
  end

  def catalog
    @filters = prepare_filters
    @items = Item.filtered(@filters).limit(24)
  end

  def more
    @filters = prepare_filters
    @items = Item.filtered(@filters).offset(params[:offset]).limit(24)
    render template: 'shop/more', layout: false
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
        brands: {
            values: Brand.cached_all,
            current: params[:brand]},
        types: {
            values: Type.cached_all,
            current: params[:type]},
        countries: {
            values: Country.cached_all,
            current: params[:country]},
        sort: {
            values: Sorts,
            current: params[:sort]
        },
        search: {
          values: '',
          current: params[:search]
        }
    }
  end
end
