class AddTextToSpecial < ActiveRecord::Migration[5.0]
  def change
    add_column :specials, :text, :string
  end
end
