ActiveAdmin.register Order do

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

  show do
    panel "Order" do
      table_for order do
        column :price
        column :address
        column 'User' do
          order.user.email unless order.user.nil?
        end
        column :created_at
        column :updated_at
      end
    end
    panel "Order items" do
      table_for order.order_items do
        column "name" do |order_item|
          order_item.item.name
        end
        column :quantity
        column :unit_price
        column :total_price
      end
    end
  end

end
