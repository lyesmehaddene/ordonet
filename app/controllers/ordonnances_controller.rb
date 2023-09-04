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

  def generate_qrcode
    @ordonnance = Ordonnance.find(params[:id])
    # Assuming you have an @ordonnance object
    qrcode = RQRCode::QRCode.new(@ordonnance.to_json)
    qrcode_as_svg = qrcode.as_png(
      offset: 0,
      color: 'black',
      module_size: 6,
      standalone: true,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      size: 150
    )

    # Save the QR code as an image file
    File.open("/Users/lyesm/code/lyesmehaddene/ordonet/app/assets/images/qrcode-#{@ordonnance.ordonnance_number}.png", 'wb') do |file|
      file.write(qrcode_as_svg)
    end

    # Update the is_used flag
    @ordonnance.update(qr_generated: true)

    # Redirect or render as needed
    respond_to do |format|
      format.html { redirect_to appointment_ordonnance_path(appointment_id: @ordonnance.appointment.id, id: @ordonnance.id) }
      format.json { render json: { qr_code_url: view_context.image_url("qrcode-#{ordonnance_number}.png") } }
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
