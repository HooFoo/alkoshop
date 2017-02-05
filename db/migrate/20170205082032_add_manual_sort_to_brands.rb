class AddManualSortToBrands < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :sort, :integer
    Brand.all.each_with_index do |brand, index|
      brand.sort = index
      brand.save
    end
  end
end
