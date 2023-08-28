class Doctor < ApplicationRecord

  validates :foreign_key, presence: true
  validates :foreign_key, uniqueness: true

  belongs_to :user
  has_many :appointments
  has_many :patients, through: :appointments
end
