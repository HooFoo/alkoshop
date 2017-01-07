class ItemsVolume < ApplicationRecord
  belongs_to :volume
  belongs_to :item
  validates :price, numericality: { greater_than_or_equal_to: 1}

  def price
    sprice = super
    if sprice.modulo(1) == 0
      sprice.to_i
    else
      sprice
    end
  end
end
