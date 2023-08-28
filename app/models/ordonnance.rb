class Ordonnance < ApplicationRecord

  validates :foreign_key, presence: true

  belongs_to :appointment
  has_many :ordo_medications
  has_many :medications, through: :ordo_medications
end
