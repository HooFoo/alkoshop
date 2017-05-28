class DiscountCard < ApplicationRecord
  DISCOUNTS = {
      '10%' => 10,
      '20%' => 20,
      '25%' => 25
  }

  validates :discount, presence: true
  validates :number, presence: true
  validates :user_email, presence: true

  has_one :user, required: false

  def to_s
    number
  end
end
