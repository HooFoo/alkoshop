class AddStateToOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :state, :string
    change_table :orders_mailer do |t|
      t.belongs_to :order_state
    end
  end
end
