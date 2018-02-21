class Band < ApplicationRecord
  validates :title, presence: true
  has_many :artists
  has_many :concert_bands
  has_many :concerts, through: :concert_bands
end
