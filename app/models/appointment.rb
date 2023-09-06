class Appointment < ApplicationRecord
  has_one :ordonnance, dependent: :destroy
  belongs_to :patient
  belongs_to :doctor
end
