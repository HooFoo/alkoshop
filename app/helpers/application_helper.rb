module ApplicationHelper
  def item_link item
    "/shop/catalog?brand=#{item.brand}&type=#{item.type}&country=#{item.country}#item=#{item.id}"
  end
end
