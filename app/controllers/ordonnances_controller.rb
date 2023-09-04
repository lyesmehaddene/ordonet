class OrdonnancesController < ApplicationController
  before_action :get_appointment_id, only: %i[show new create]

  def show
    @ordonnance = Ordonnance.find(params[:id])
  end

  def new
    @ordonnance = Ordonnance.new(appointment: @appointment)
    @ordonnance.ordonnance_number = rand(100000..999999999)
    if @ordonnance.save
      redirect_to appointment_ordonnance_path(appointment_id: @appointment.id, id: @ordonnance.id)
    else
      render :new, status: :unprocessable_entity
    end
    @appointment.ordonnance_id = @ordonnance.id
    @appointment.save
  end

  def create
    @ordonnance = Ordonnance.new(ordonnance_params)
    @ordonnance.appointment = get_appointment_id
    if @ordonnance.save
      redirect_to appointment_ordonnance_path(appointment_id: @appointment.id, id: @ordonnance.id)
    else
      puts @ordonnance.errors.full_messages # Print validation errors for debugging
      render :new, status: :unprocessable_entity
    end
  end

  def create_pdf
    @appointment = Appointment.find(params[:appointment_id])
    @ordonnance = Ordonnance.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{current_user.first_name}_#{current_user.last_name}-#{@appointment.patient.user.first_name}_#{@appointment.patient.user.last_name}_#{Date.today}", # Excluding ".pdf" extension.
        template: "ordonnances/show",
        layout: 'pdf',
        disposition: :inline
        # locals: { ordonnance: @ordonnance }
      end
    end
    # respond_to do |format|
    #   format.pdf do
    #     pdf_content = generate_pdf_content
    #     send_data pdf_content,
    #       filename: "#{@current_user.first_name}_#{@current_user.last_name}-#{@appointment.patient.user.first_name}_#{@appointment.patient.user.last_name}_#{Date.today}.pdf",
    #       type: "application/pdf",
    #       disposition: "inline" # Use "inline" to open the PDF in the browser, or "attachment" to force a download
    #   end
    # end
  end

  private

  def generate_pdf_content
    render_to_string(
      template: "ordonnances/show.pdf.erb",
      layout: 'pdf.html.erb',
      locals: { ordonnance: @ordonnance }
    )
    pdf # Make sure to return the generated PDF content
  end


  def get_appointment_id
    @appointment = Appointment.find(params[:appointment_id])
  end

  def ordonnance_params
    params.require(:ordonnance).permit(:content)
  end
end
