class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  # validates :status, presence: true
  belongs_to :user
  def total_price
    line_items.to_a.sum { |item| item.quantity * item.price }
  end
end
