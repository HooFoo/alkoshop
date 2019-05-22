module ApplicationHelper
  def item_link item
    "/shop/catalog?brand=#{item.brand.id}&type=#{item.type.id}&country=#{item.country.id}#item=#{item.id}"
  end
end
