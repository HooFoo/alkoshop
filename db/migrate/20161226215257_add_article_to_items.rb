class AddArticleToItems < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.string :article
    end
  end
end
