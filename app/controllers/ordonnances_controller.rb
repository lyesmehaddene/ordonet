class OrdonnancesController < ApplicationController
  def show
  end

  def new
    @ordonnance = Ordonnance.new
  end

  def create
    @ordonnance = Ordonnance.new(ordonnance_params)
    @ordonnance.appointment = get_appointment_id
    if @ordonnance.save
      redirect_to ordonnance_path(@ordonnance)
    else
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
