class Order < ApplicationRecord
  belongs_to :user

  scope :in_progress, ->{where("state = 'complete' ")}
  scope :complete, -> {where("state = 'in_progress' ")}
end
