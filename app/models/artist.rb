class Artist < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  has_many :concerts, through: :venue_artist_concerts
end
