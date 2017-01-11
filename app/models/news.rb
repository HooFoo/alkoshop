class News < ApplicationRecord
  default_scope { all.order(:updated_at).reverse_order }

  def short_description(length = 140)
    description.slice(0, length)
  end

  mount_uploader :image, ImagesUploader
end
