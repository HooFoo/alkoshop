ActiveAdmin.register Order do



  show do
    panel "Order" do
      table_for order do
        column :price
        column :address
        column :delivery
        column 'User' do
          order.user.email unless order.user.nil?
        end
        column 'Discount card' do
          order.user.discount_card.number if order.user&.discount_card
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
        column :volume
        column :quantity
        column :unit_price
        column :total_price
      end
    end
  end

end
