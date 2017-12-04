class Concert < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  
  has_many :concert_bands
  has_many :bands, through: :concert_bands
  has_one :chat_box, dependent: :destroy
  has_many :messages, through: :chat_box, dependent: :destroy
  has_many :tweets, dependent: :destroy
end
