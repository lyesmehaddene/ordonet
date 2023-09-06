class PatientsController < ApplicationController
  def index
    @patients = current_user.doctor.patients.distinct
  end

    def show
      @patient = Patient.find(params[:id])
      @appointment = @patient.appointments.last
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
    begin
      search_date = Date.strptime(params[:day], "%d/%m/%Y")
    rescue ArgumentError
      flash[:error] = 'Invalid date format. Please use the format dd/mm/yyyy.'
      return
    end
  else
    search_date = Date.current
  end

  @patients = current_user.doctor.patients.joins(:appointments)
              .where('DATE(appointments.appointment_date) = ?', search_date)
              .distinct
  @patient_count = @patients.count

  render 'pages/dashboard'
  end
end
