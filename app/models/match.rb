class Match < ApplicationRecord

  belongs_to :team

  validates :name, presence: true
  validates :uuid, presence: true
  validates :date, presence: true

end
