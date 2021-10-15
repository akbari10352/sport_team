class Team < ApplicationRecord

  has_many :players
  has_many :matches
  belongs_to :user

  validates :name, presence: true

end
