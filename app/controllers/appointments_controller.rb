class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show edit update destroy]

  def index
    @appointments = Appointment.find_by(patient: params[:patient_id])
  end

  def show; end

  def create
    @appointment = Appointment.new()
    @appointment.patient = get_patient_id
    @appointment.doctor = current_user.doctor
    @appointment.appointment_date = Date.today
    if params[:commit] == 'Confirmer le nouveau rendez-vous'
      if @appointment.save
        redirect_to appointment_path(@appointment)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
    render json: { html_content: render_to_string(partial: 'edit_form', locals: { appointment: @appointment }, formats: [:html]) }
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.update(appointment_params)
    redirect_to appointment_path(@appointment)
  end

  def new
    @appointment = Appointment.new
  end

  private

  def appointment_params
    params.require(:appointment).permit(:patient_id, :doctor_id)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def get_patient_id
    @patient_first_name = params["appointments"]["first_name"]
    @patient_last_name = params["appointments"]["last_name"]
    @user_patient = User.find_by(first_name: @patient_first_name, last_name: @patient_last_name)
    Patient.find_by(user_id: @user_patient.id)
  end
end
