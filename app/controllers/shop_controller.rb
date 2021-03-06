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
    if params[:special]
      @items = Special.find(params[:special]).items_volumes.map(&:item)
      @specials = true
    else
      @items = Item.filtered(@filters).limit(24)
      @specials = false
    end
  end

  def more
    @filters = prepare_filters

    if params[:special]
      @items = []
    else
      @items = Item.filtered(@filters).offset(params[:offset]).limit(24)
    end
    render template: 'shop/more', layout: false

  end

  def template
    if params[:brand]
      @brand = Brand.find params[:brand]
    end
    if params[:item]
      @item = Item.find params[:item]
      @same = Item.same @item
      special_prices
    end
    if request.xhr?
      super
    else
      if @brand.nil?
        redirect_to "/shop/catalog#item=#{@item.id}"
      else
        redirect_to "/shop/brands#brand=#{@brand.id}"
      end
    end
  end

  private

  def prepare_filters
    {
        brands: {
            values: Brand.cached_all.map {|i| [i.name, i.id]},
            current: params[:brand]},
        types: {
            values: Type.cached_all.map {|i| [i.name, i.id]},
            current: params[:type]},
        countries: {
            values: Country.cached_all.map {|i| [i.name, i.id]},
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
      @prices = @item.special_price.select { |item| !item.special.nil? }
  end
end
