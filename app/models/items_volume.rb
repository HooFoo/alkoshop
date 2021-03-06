class ItemsVolume < ApplicationRecord
  belongs_to :volume
  belongs_to :item
  belongs_to :special

  validates :price, numericality: { greater_than_or_equal_to: 1}

  def show_price
    sprice = price
    if sprice.modulo(1) == 0
      sprice.to_i
    else
      sprice
    end
  end
end
