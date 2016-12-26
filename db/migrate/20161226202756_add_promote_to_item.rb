class AddPromoteToItem < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.boolean :promote
    end
  end
end
