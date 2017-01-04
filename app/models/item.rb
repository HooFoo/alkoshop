class Item < ApplicationRecord
  belongs_to :brand
  belongs_to :type
  belongs_to :country

  has_and_belongs_to_many :volumes

  mount_uploader :image, ImagesUploader

  default_scope { where('in_stock > 0') }


  def self.promoted
    where(promote: true).sample
  end

  def self.same(item)
    Item.where(type: item.type).sample(4)
  end

  def self.filtered(filters, options = {limit:24, offset:0})
    wheres = []
    names = filters.map do |type,filter|
      unless filter[:current].empty? || type == :sort
        wheres << "#{type}.name = '#{filter[:current].to_s}'"
        type.to_s.singularize.to_sym
      end
    end
    Item.joins(*names).where(wheres.join(' AND ')).order(filters[:sort][:current])
  end


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
end
