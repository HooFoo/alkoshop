class News < ApplicationRecord
  default_scope { where.not(title: 'О проекте').order(:updated_at).reverse_order }

  def short_description(length = 140)
    description.slice(0, length)
  end

  mount_uploader :image, ImagesUploader
end
