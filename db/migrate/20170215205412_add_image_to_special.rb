class AddImageToSpecial < ActiveRecord::Migration[5.0]
  def change
    add_column :specials, :image, :string
  end
end
