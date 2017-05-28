class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  belongs_to :volume

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :item_present
  validate :order_present

  before_save :finalize

  def initialize opts
    super opts
    @quantity = opts[:quantity] || 1
    @item = Item.find opts[:item_id]
  end

  def unit_price(discount = 0)
    discount = if order.discount_card
                 1.0 - order.discount_card.discount / 100.0
               else
                 1
               end
    if !self[:unit_price].nil?
      price = self[:unit_price]
    else
      price = item.price
    end
    if price.modulo(1) == 0
      price.to_i * discount
    else
      price * discount
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
