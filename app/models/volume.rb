class Volume < ApplicationRecord
  has_and_belongs_to_many :items

  def to_s
    ml
  end

end
