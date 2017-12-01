class Concert < ApplicationRecord
  
  has_many :artists, through: :concert_band
  # belongs_to :venue, through: :venue_artist_concert
  has_one :chat_box, dependent: :destroy
  has_many :messages, through: :chat_box, dependent: :destroy
  has_many :tweets, dependent: :destroy
end
