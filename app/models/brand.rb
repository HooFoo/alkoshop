class Brand < ApplicationRecord
  mount_uploader :image, ImagesUploader

  def to_s
    name
  end
end
