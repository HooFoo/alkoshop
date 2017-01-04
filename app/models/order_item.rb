class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :item_present
  validate :order_present

  before_save :finalize

  def initialize opts
    super opts
    @quantity = opts[:quantity] || 1
    @item = Item.find opts[:item_id]
  end

  def unit_price
    if persisted?
      self[:unit_price]
    else
      item.price
    end
  end

  def total_price
    unit_price * quantity
  end

  private

  def item_present
    if item.nil?
      errors.add(:item, "Извините, данная позиция более недоступна.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "Извините, этот заказ более недоступен. Попробуйте собрать его заново.")
    end
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end