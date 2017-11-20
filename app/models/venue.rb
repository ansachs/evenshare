class Venue < ApplicationRecord
  has_many :concerts, through: :venue_artist_concerts
end
