class Item < ApplicationRecord
  belongs_to :brand
  belongs_to :type
  belongs_to :country
  has_many :items_volumes, dependent: :destroy
  has_many :volumes, through: :items_volumes
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :items_volumes, allow_destroy: true

  validates :items_volumes, presence: true
  validates :brand, presence: true
  validates :type, presence: true
  validates :country, presence: true
  
  before_save :set_price

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
      all = Item.joins(*names).where(wheres.join(' AND '))
    else
      all = Item.all
    end
    all.order(filters[:sort][:current])
  end


  def short_description
    "#{type} #{type_extra}. #{region}"
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

  def without_special
    items_volumes.select {|iv| iv.special.nil?}
  end

  def with_special user
    special = user.special
    items_volumes.select {|iv| iv.special == special}
  end

  def all_prices user
    without = without_special.to_a
    special = with_special(user).to_a
    all = (without + special)
    volumes = all.map(&:volume)
    dups = volumes.select {|item| volumes.count(item) > 1}
    all.each do |item|
      if dups.include?(item.volume) &&  item.special.nil?
        all.delete item
      end
    end
    all
  end

  private

  def set_price
    self.price = items_volumes.first.price
  end
end
