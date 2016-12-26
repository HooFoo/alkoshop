class CreateVolumes < ActiveRecord::Migration[5.0]
  def change
    create_table :volumes do |t|
      t.integer :ml

      t.timestamps
    end
  end
end
