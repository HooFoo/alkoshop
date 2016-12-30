class Item < ApplicationRecord
  belongs_to :brand
  belongs_to :type
  belongs_to :country

  has_and_belongs_to_many :volumes

  mount_uploader :image, ImagesUploader

  def short_description
    "#{type_extra}. #{region}"
  end

  def heading
    "#{source}"
  end

  def show_price
    if price.modulo(1) == 0
      price.to_i
    else
      price
    end
  end

  def self.promoted
    where(promote: true).sample
  end

  def self.same item
    Item.where(type: item.type).sample(4)
  end
end
