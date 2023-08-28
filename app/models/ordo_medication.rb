class OrdoMedication < ApplicationRecord

  validates :foreign_key, presence: true

  belongs_to :ordonnance
end
