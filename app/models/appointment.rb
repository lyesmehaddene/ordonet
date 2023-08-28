class Appointment < ApplicationRecord

  validates :foreign_key, presence: true

  belongs_to :patient
  belongs_to :doctor
end
