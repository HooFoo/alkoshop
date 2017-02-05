ActiveAdmin.register Brand do
  permit_params  :name, :description, :image, :sort

  index :as => :grid do |brand|
    a truncate(brand.name), :href => admin_brand_path(brand)
    div do
      a :href => admin_brand_path(brand) do
        image_tag(brand.image.url(:thumb))
      end
    end
    a truncate(brand.description), :href => admin_brand_path(brand)
  end


# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
