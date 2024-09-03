class Cart < ApplicationRecord
  has many :line_items

  validates :status, presence: true
end
