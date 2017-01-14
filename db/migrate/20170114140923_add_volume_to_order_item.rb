class AddVolumeToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :volume_id, :integer, index: true
  end
end
