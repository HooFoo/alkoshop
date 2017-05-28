class CreateDiscountCards < ActiveRecord::Migration[5.0]
  def change
    create_table :discount_cards do |t|
      t.string :number
      t.string :user_name
      t.string :user_email
      t.integer :discount
      t.index :number, unique: true
    end
    change_table :users do |t|
      t.belongs_to :discount_card
    end
  end
end
