ActiveAdmin.register Item do
  permit_params  :name, :image, :price, :type_extra, :region, :facturer,
                 :alcohol, :source, :volume_ids, :description, :promote, :article,
                 :brand_id, :type_id, :country_id, :in_stock

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
