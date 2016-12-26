class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.belongs_to :brand, foreign_key: true, index: true
      t.belongs_to :type, foreign_key: true, index: true
      t.string :name
      t.string :image
      t.float :price
      t.string :type_extra
      t.string :region
      t.string :facturer
      t.float :alcohol
      t.string :source
      t.string :description

      t.timestamps
    end
  end
end
