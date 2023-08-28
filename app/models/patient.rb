class Patient < ApplicationRecord

  validates :foreign_key, presence: true
  validates :foreign_key, uniqueness: true

  belongs_to :user
  has_many :appointments
  has_many :doctors, through: :appointments
end
