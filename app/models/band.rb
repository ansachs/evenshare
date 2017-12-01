class Band < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  has_many :artists
  has_many :concerts, through: :concert_band
end
