class OrdoMedicationsController < ApplicationController
  def new
    @ordo_medication = OrdoMedication.new
  end

  def create
    @ordo_medication = OrdoMedication.new(ordo_medication_params)
    @medication = Medication.find(params["ordo_medication"]["medication_id"])
    @ordo_medication.medication_id = @medication.id
    @ordo_medication.ordonnance = Ordonnance.find(params[:ordonnance_id])

    if @ordo_medication.save
      redirect_to request.referer
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ordo_medication_params
    params.require(:ordo_medication).permit(:frequency, :duration, :commentary, :medication_id, :ordonnance_id)
  end
end
