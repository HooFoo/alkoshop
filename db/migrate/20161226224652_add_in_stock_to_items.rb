class AddInStockToItems < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.integer :in_stock
    end
  end
end
