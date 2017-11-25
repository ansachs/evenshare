class Concert < ApplicationRecord
  
  has_many :artists, through: :venue_artist_concerts
  # belongs_to :venue, through: :venue_artist_concert
  has_one :chat_box, dependent: :destroy
  has_many :messages, through: :chat_box, dependent: :destroy

end
