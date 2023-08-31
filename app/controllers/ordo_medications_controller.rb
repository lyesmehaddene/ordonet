class OrdoMedicationsController < ApplicationController
  def new
    @ordo_medication = OrdoMedication.new

  end

  def create
    @ordo_medication = OrdoMedication.new(ordo_medication_params)
    @medication = Medication.find_by(name: params[:medication_name])
    @ordo_medication.medication = @medication
    @ordo_medication.ordonnance = Ordonnance.find(params[:ordonnance_id])
    if @ordo_medication.save
      redirect_to ordonnance_path(@ordo_medication.ordonnance)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ordo_medication_params
    params.require(:ordo_medication).permit(:frequency, :duration)
  end
end
