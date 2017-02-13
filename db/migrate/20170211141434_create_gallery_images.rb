class CreateGalleryImages < ActiveRecord::Migration[5.0]
  def change
    create_table :gallery_images do |t|
      t.string :image
      t.belongs_to :brand, foreign_key: true
      t.belongs_to :news, foreign_key: true
      t.integer :sort

      t.timestamps
    end
  end
end
