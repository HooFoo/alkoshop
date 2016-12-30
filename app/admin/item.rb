ActiveAdmin.register Item do
  permit_params  :name, :image, :price, :type_extra, :region, :facturer,
                 :alcohol, :source, :description, :promote, :article,
                 :brand_id, :type_id, :country_id, :in_stock, :volume_ids => []

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

  form do |f|
    f.semantic_errors # shows errors on :base
    f.actions
    f.inputs 'Items' do
      f.input :name
      f.input :image
      f.input :price
      f.input :type_extra
      f.input :region
      f.input :facturer
      f.input :volumes, :as => :select, :input_html => {:multiple => true}
      f.input :brand, :as => :select
      f.input :type, :as => :select
      f.input :country, :as => :select
      f.input :alcohol
      f.input :source
      f.input :description
      f.input :promote
      f.input :article
      f.input :in_stock

    end
    f.actions
  end

end
