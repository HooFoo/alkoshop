class Special < ApplicationRecord
  has_many :users
  has_many :items_volumes, dependent: :destroy
  accepts_nested_attributes_for :items_volumes, allow_destroy: true
  accepts_nested_attributes_for :users, allow_destroy: false

  before_destroy :clear_users

  mount_uploader :image, SpecialUploader

  def to_s
    text
  end
  private

  def clear_users
    users.each do |user|
      user.special = nil
      user.save
    end
  end
end
