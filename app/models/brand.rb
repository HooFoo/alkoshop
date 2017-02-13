class Brand < ApplicationRecord

  has_many :gallery_images, dependent: :destroy
  accepts_nested_attributes_for :gallery_images, allow_destroy: true

  mount_uploader :image, ImagesUploader

  validates :sort, uniqueness: true

  default_scope { order('sort')}
  def to_s
    name
  end
end
