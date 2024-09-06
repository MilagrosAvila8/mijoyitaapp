class Product < ApplicationRecord
  has_many :carts, through: :line_items
  has_many :line_items, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
  validates :price, presence: true
  validates :comment, length: { minimum: 15 }
  has_one_attached :photo

  validate :image_presence

  private

  def image_presence
    errors.add(:photo, "Falta agregar la imagen") unless photo.attached?
  end
end
