class AddDiscountCardToOrder < ActiveRecord::Migration[5.0]
  def change
    change_table :orders do |t|
      t.belongs_to :discount_card
    end
  end
end
