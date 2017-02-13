class GalleryImage < ApplicationRecord
  belongs_to :brand
  belongs_to :news

  mount_uploader :image, GalleryUploader

  default_scope {order(:sort)}
end
