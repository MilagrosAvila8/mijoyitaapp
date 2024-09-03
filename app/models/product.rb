class Product < ApplicationRecord
  has_many :carts, through: :line_items, dependent: :destroy
  has_many :line_items, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  validates :comment, length: { minimum: 15 }
end
