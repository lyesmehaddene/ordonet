class Medication < ApplicationRecord

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :ordo_medications
  has_many :ordonnances, through: :ordo_medications
end
