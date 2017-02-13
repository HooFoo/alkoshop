ActiveAdmin.register Brand do
  permit_params  :name, :description, :image, :sort, :gallery_images_attributes => [:id, :image, :sort, :_destroy]

  index :as => :grid do |brand|
    a truncate(brand.name), :href => admin_brand_path(brand)
    div do
      a :href => admin_brand_path(brand) do
        image_tag(brand.image.url(:thumb))
      end
    end
    a truncate(brand.description), :href => admin_brand_path(brand)
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.actions
    f.inputs 'Brands' do
      f.input :name
      f.input :image
      f.input :description
      f.input :sort
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

  end

  show do
    panel "Brand" do
      table_for brand do
        column :name
        column :description
        column 'Image' do |brand|
          image_tag brand.image.thumb, class: 'thumb'
        end
        column :sort
        column :created_at
        column :updated_at
      end
    end
    panel "Gallery" do
      table_for brand.gallery_images do
        column :sort

        column 'Image' do |g_img|
          image_tag g_img.image.thumb, class: 'thumb'
        end
      end
    end
  end
end
