class ChatBox < ApplicationRecord

  has_many :messages
  belongs_to :concert
end
