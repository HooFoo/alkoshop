class Item < ApplicationRecord
  belongs_to :brand
  belongs_to :type
  belongs_to :country

  has_and_belongs_to_many :volume

  mount_uploader :image, ImagesUploader

  def short_description
    "#{type_extra}. #{region}"
  end

  def heading
    "#{source}"
  end

  def self.promoted
    where(promote: true).sample
  end
end
