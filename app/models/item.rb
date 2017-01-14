class Item < ApplicationRecord
  belongs_to :brand
  belongs_to :type
  belongs_to :country
  has_many :items_volumes, dependent: :destroy
  has_many :volumes, through: :items_volumes
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :items_volumes, allow_destroy: true

  validates :volumes, presence: true

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
      unless filter[:current].nil? || filter[:current].empty? || type == :sort
        if type == :search
          wheres << "items.name LIKE '%#{filter[:current]}%'"
          nil
        else
          wheres << "#{type}.name = '#{filter[:current].to_s}'"
          type.to_s.singularize.to_sym
        end
      end
    end
    if wheres.size > 0
      Item.joins(*names).where(wheres.join(' AND ')).order(filters[:sort][:current])
    else
      Item.all
    end
  end


  def short_description
    "#{type_extra}. #{region}"
  end

  def heading
    "#{source}"
  end

  def show_price
    if items_volumes.first.nil?
      real_price = price
    else
      real_price = items_volumes.first.price
    end
    if real_price.to_f.modulo(1) == 0
      real_price.to_i
    else
      real_price
    end
  end
end
