class Brand < ApplicationRecord
  mount_uploader :image, ImagesUploader

  validates :sort, uniqueness: true

  default_scope { order('sort')}
  def to_s
    name
  end
end
