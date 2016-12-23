class Brand < ApplicationRecord
  mount_uploader :image, ImagesUploader
end
