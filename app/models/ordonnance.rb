class Ordonnance < ApplicationRecord
  has_one_attached :photo

  belongs_to :appointment

  has_many :ordo_medications
  has_many :medications, through: :ordo_medications
end
