class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order_state
  has_many :order_items, dependent: :destroy
  before_create :set_order_status
  before_save :update_subtotal

  scope :in_progress, -> { joins(:order_state).where('order_states.name': 'In progress') }
  scope :complete, -> { joins(:order_state).where('order_states.name': 'Finished') }

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def has_user?
    !user.nil?
  end

  def show_price
    sub = subtotal
    if sub.modulo(1) == 0
      sub.to_i
    else
      sub
    end
  end

  def complete! address, delivery
    if order_items.size > 0
      self.address = address
      self.delivery = delivery
      self.order_state = OrderState.where(name: 'Finished').first_or_create!
      OrdersMailer.send_order_mail(self).deliver!
      self.order_items.each do |oitem|
        oitem.item.in_stock -= oitem.quantity
        oitem.item.save
      end
      save!
    else
      false
    end
  end

  private

  def set_order_status
    self.order_state_id = OrderState.where(name: 'In progress').first_or_create!.id
  end

  def update_subtotal
    self[:price] = subtotal
  end


end
