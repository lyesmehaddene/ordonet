class Appointment < ApplicationRecord
  has_one :ordonnance
  belongs_to :patient
  belongs_to :doctor
end
