class SpecialsForAll < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, :special_id
    remove_column :users, :special_id
  end
end
