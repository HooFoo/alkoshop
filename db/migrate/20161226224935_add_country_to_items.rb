class AddCountryToItems < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.belongs_to :country, index: true, foregin_key: true
    end
  end
end
