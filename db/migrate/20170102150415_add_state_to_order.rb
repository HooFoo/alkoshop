class AddStateToOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :state, :string
    change_table :orders do |t|
      t.belongs_to :order_state
    end
  end
end
