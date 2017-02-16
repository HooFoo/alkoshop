class ShopController < ApplicationController


  Sorts = {
      'Сначала новые': 'created_at DESC',
      'Сначала старые': 'created_at ASC',
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
      unless @user.special.nil?
        special_prices
      end
    end
    if request.xhr?
      super
    else
      if @brand.nil?
        redirect_to "/shop/catalog#item=#{@item.id}"
      else
        redirect_to "/shop/brands#brand=#{@brand.name}"
      end
    end
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
            current: params[:sort] || Sorts.first[1]
        },
        search: {
          values: '',
          current: params[:search]
        }
    }
  end

  def special_prices
    unless @item.nil?
      @prices = @item.all_prices @user
    end
  end
end
