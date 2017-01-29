class AboutNews < ActiveRecord::Migration[5.0]
  def change
    News.create title: 'О проекте', description: 'Вставить текст о проекте'
  end
end
