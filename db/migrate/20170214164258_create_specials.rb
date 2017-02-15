class CreateSpecials < ActiveRecord::Migration[5.0]
  def change
    create_table :specials do |t|
      t.timestamps
    end
    add_column :users, :special_id, :integer
    add_index :users, :special_id
    add_column :items_volumes, :special_id, :integer
    add_index :items_volumes, :special_id

  end
end
