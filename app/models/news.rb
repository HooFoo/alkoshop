class News < ApplicationRecord

  has_many :gallery_images, dependent: :destroy
  accepts_nested_attributes_for :gallery_images, allow_destroy: true


  default_scope { order(:updated_at).reverse_order }

  def short_description(length = 340)
    description.slice(0, length)
  end

  mount_uploader :image, ImagesUploader
end
