ActiveAdmin.register News do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :title, :description, :media, :image
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

 form do |f|
  f.inputs do
   f.input :title
   f.input :image
   f.input :media, :as => :text
   f.input :description, :as => :ckeditor
  end
  f.actions
 end
end
