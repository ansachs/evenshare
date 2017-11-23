class Concert < ApplicationRecord
  
  has_many :artists, through: :venue_artist_concerts
  # belongs_to :venue, through: :venue_artist_concert
  has_many :chats, dependent: :destroy
  has_many :users, through: :chats
end
