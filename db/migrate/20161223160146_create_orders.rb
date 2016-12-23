class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user, foreign_key: true
      t.float :price
      t.string :address
      t.string :state

      t.timestamps
    end
  end
end
