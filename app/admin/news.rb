ActiveAdmin.register News do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :title, :description, :media, :image, :updated_at, :gallery_images_attributes => [:id, :image, :sort, :_destroy]
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
   f.input :updated_at, as: :datepicker
   f.input :image
   f.input :media, :as => :text
   f.input :description, :as => :ckeditor
  end
  f.inputs do
   f.has_many :gallery_images do |g_image|
    if !g_image.object.nil?
     # show the destroy checkbox only if it is an existing appointment
     # else, there's already dynamic JS to add / remove new appointments
     g_image.input :_destroy, :as => :boolean, :label => "Destroy?"
    end

    g_image.input :image
    g_image.input :sort
   end
  end
  f.actions
 end

 show do
  panel "news" do
   table_for news do
    column :title
    column :description
    column 'Image' do |brand|
     image_tag brand.image.thumb, class: 'thumb'
    end
    column :media
    column :created_at
    column :updated_at
   end
  end
  panel "Gallery" do
   table_for news.gallery_images do
    column :sort

    column 'Image' do |g_img|
     image_tag g_img.image.thumb, class: 'thumb'
    end
   end
  end
 end
end
