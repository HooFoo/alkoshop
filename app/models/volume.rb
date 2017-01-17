class Volume < ApplicationRecord
  has_many :items_volumes
  has_many :items, through: :items_volumes

  def to_s
    ml.to_s
  end

end
