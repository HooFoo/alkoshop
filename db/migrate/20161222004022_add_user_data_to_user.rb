class AddUserDataToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :name
      t.string :surname
      t.string :phone
      t.string :country
      t.string :district
      t.string :city
    end
  end
end
