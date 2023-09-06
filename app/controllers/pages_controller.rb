class PagesController < ApplicationController
  def home
  end

  def dashboard
    @current_date = Date.today
    @patients = current_user.doctor.patients.joins(:appointments)
                .where('DATE(appointments.appointment_date) = ?', @current_date)
                .distinct
    @patient_count = @patients.count
  end
end
