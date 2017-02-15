class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  belongs_to :special

  scope :no_special, -> { left_outer_joins(:special).where( users: { special_id: nil } )}
end

