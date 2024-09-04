class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  # validates :status, presence: true
  belongs_to :user
end
