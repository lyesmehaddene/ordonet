class PatientsController < ApplicationController
  def index
    @patients = current_user.doctor.patients.distinct
  end

  def show
  end

  def new
    @patient = Patient.new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def search
    if params[:search].present?
      @patients = current_user.doctor.patients.joins(:user)
                    .where('users.first_name LIKE ?', "%#{params[:search]}%")
                    .distinct
    else
      @patients = current_user.doctor.patients.distinct
    end
    render 'index'
  end

  def search_by_day
    if params[:day].present?
      search_date = Date.strptime(params[:day], "%d/%m/%Y")
      @patients = current_user.doctor.patients.joins(:appointments)
                  .where('DATE(appointments.appointment_date) = ?', search_date)
                  .distinct
      @patient_count = @patients.count
    else
      @patients = current_user.doctor.patients.distinct
      @patient_count = 0
    end

    render 'pages/dashboard'
  end
end
