class AddPriceToItemsVolumes < ActiveRecord::Migration[5.0]
  def change
    change_table :items_volumes do |t|
      t.primary_key :id, index: true
      t.float :price
    end
  end
end
