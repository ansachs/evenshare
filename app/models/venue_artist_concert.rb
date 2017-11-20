class VenueArtistConcert < ApplicationRecord
  belongs_to :artist
  belongs_to :venue 
  belongs_to :concert 
end
