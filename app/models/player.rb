class Player < ApplicationRecord
  belongs_to :team

  validates :name, presence: true
  validates :uuid, presence: true

end
