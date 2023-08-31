class OrdonnancesController < ApplicationController

  before_action :get_appointment_id, only: %i[show new create]

  def show
    @ordonnance = Ordonnance.find(params[:id])
  end

  def new
    @ordonnance = Ordonnance.new
  end

  def create
    @ordonnance = Ordonnance.new(ordonnance_params)
    @ordonnance.appointment = get_appointment_id
    @ordonnance.ordonnance_number = rand(100000..999999999)
    if @ordonnance.save
      redirect_to ordonnance_path(@ordonnance)
    else
      puts @ordonnance.errors.full_messages # Print validation errors for debugging
      render :new, status: :unprocessable_entity
    end
  end

  private
  def get_appointment_id
    @appointment = Appointment.find(params[:appointment_id])
  end

  def ordonnance_params
    params.require(:ordonnance).permit(:content)
  end
end
