class User < ApplicationRecord

  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :at_least_one_flag_true

  private

  def at_least_one_flag_true
    unless patient || doctor
      errors.add(:base, "At least one of flag1 or flag2 must be true")
    end
  end

end
