class Venue < ApplicationRecord
  validates :title, presence: true
  validates :address, presence: true
  has_many :concerts
end
