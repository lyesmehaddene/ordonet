require 'rqrcode'

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
  end

  def generate_qrcode
    @ordonnance = Ordonnance.find(params[:id])
    # Assuming you have an @ordonnance object
    qrcode = RQRCode::QRCode.new(@ordonnance.to_json)
    qrcode_as_png = qrcode.as_png(
      offset: 0,
      color: 'black',
      module_size: 6,
      standalone: true,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      size: 150
    )

    # Save the QR code as an image file
    File.open(Rails.root.join('tmp', "qrcode-#{@ordonnance.ordonnance_number}.png"), 'wb') do |file|
      file.write(qrcode_as_png)
    end

    # Update the is_used flag
    @ordonnance.update(qr_generated: true)

    # Redirect or render as needed
    respond_to do |format|
      format.html { redirect_to appointment_ordonnance_path(appointment_id: @ordonnance.appointment.id, id: @ordonnance.id) }
      format.json { render json: { qr_code_url: asset_path("qrcode-#{ordonnance_number}.png") } }
    end
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
