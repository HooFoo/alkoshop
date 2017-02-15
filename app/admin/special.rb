ActiveAdmin.register Special do

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

  permit_params user_ids: [], users_attributes: [:id, :special_id], items_volumes_attributes: [:id, :volume_id, :item_id, :price, :_destroy]

  form do |f|
    f.semantic_errors # shows errors on :base
    f.actions
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
    f.inputs do
      f.input :users,as: :select, multiple: true, collection: (special.users + User.no_special).map {|u| ["#{u.email} #{u.name}", u.id]}
    end
    f.actions
  end

  show do
    panel "Special" do
      table_for special do
        column :id
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
    panel "Users" do
      table_for special.users do
        column "name" do |user|
          user.name
        end
        column "email" do |user|
          user.email
        end
      end
    end
  end
end
