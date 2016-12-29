class AddVolumesToItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items_volumes, id: false do |t|
      t.belongs_to :volume, index: true
      t.belongs_to :item, index: true
    end
  end
end
