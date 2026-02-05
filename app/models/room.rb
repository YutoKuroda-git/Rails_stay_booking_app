class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :price_per_night,
            presence: true,
            numericality: { greater_than_or_equal_to: 1 }
end
