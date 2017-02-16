class Special < ApplicationRecord
  has_many :items_volumes, dependent: :destroy
  accepts_nested_attributes_for :items_volumes, allow_destroy: true

  mount_uploader :image, SpecialUploader

  def to_s
    text
  end

  def single?
    items_volumes.size == 1
  end

end
