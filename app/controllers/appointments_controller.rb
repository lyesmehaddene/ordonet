class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.find_by(patient: params[:patient_id])
  end

  def show; end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.patient = get_patient_id
    @appointment.doctor = current_user
    if @appointment.save
      redirect_to appointment_path(@appointment)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @appointment = Appointment.new
  end

  private

  def appointment_params
    params.require(:appointment).permit(:first_name, :last_name)
  end

  def get_patient_id
    @patient_first_name = params[:patient_first_name]
    @patient_last_name = params[:patient_last_name]
    @patient = Patient.find_by(first_name: @patient_first_name, last_name: @patient_last_name)
    @patient.id
  end
end
