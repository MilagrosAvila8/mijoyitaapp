class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :price, presence: true
  validates :quantity, presence: true
end
