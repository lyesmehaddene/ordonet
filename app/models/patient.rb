# app/models/patient.rb
class Patient < ApplicationRecord
  belongs_to :user
  has_many :appointments
  has_many :doctors, through: :appointments


  def age
    now = Time.now.utc.to_date
    birthdate = user.birthday
    age = now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
    age
  end
end
