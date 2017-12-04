class Tweet < ApplicationRecord
  validates :message, presence: true
  validates :twitterID, presence: true
  belongs_to :concert
end
