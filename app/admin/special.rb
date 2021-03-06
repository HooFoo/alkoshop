ActiveAdmin.register Special do



  permit_params :text, :image, items_volumes_attributes: [:id, :volume_id, :item_id, :price, :_destroy]

  form do |f|
    f.semantic_errors # shows errors on :base
    f.actions
    f.inputs do
      f.input :text
      f.input :image
    end
    f.inputs do
      f.has_many :items_volumes do |item_volume|
        if !item_volume.object.nil?
          # show the destroy checkbox only if it is an existing appointment
          # else, there's already dynamic JS to add / remove new appointments
          item_volume.input :_destroy, :as => :boolean, :label => "Destroy?"
        end

        item_volume.input :volume, collection: Volume.all# it should automatically generate a drop-down select to choose from your existing patients
        item_volume.input :price
        item_volume.input :item, collection: Item.all.map { |i| [i.name, i.id]}
      end
    end
    f.actions
  end

  show do
    panel "Special" do
      table_for special do
        column :id
        column :text
        column :created_at
        column :updated_at
      end
    end
    panel "Items" do
      table_for special.items_volumes do
        column "name" do |item|
          item.item.name
        end
        column "volume" do |item|
          item.volume.ml
        end
        column "price" do |item|
          item.price
        end
      end
    end
  end
end
