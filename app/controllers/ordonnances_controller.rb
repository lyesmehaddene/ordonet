require 'rqrcode'
require 'stringio'

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

    # Générer le code QR avec RQRCode
    qrcode = RQRCode::QRCode.new(@ordonnance.to_json)
    qrcode_as_png = qrcode.as_png(
      offset: 0,
      color: 'black',
      module_size: 6,
      standalone: true,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      size: 150
    )

    # Convertir le PNG en StringIO
    png_io = StringIO.new
    qrcode_as_png.write(png_io)
    png_io.rewind

    # Attacher l'image à l'ordonnance avec Active Storage
    @ordonnance.photo.attach(io: png_io, filename: 'qrcode.png', content_type: 'image/png')

    # Mettre à jour le flag is_used
    @ordonnance.update(qr_generated: true)

    # Redirection ou rendu selon les besoins
    respond_to do |format|
      format.html { redirect_to appointment_ordonnance_path(appointment_id: @ordonnance.appointment.id, id: @ordonnance.id) }
      format.json { render json: { qr_code_url: url_for(@ordonnance.photo) } }
    end
  end


  # def generate_qrcode
  #   @ordonnance = Ordonnance.find(params[:id])
  #   # Assuming you have an @ordonnance object
  #   qrcode = RQRCode::QRCode.new(@ordonnance.to_json)
  #   qrcode_as_svg = qrcode.as_png(
  #     offset: 0,
  #     color: 'black',
  #     module_size: 6,
  #     standalone: true,
  #     color_mode: ChunkyPNG::COLOR_GRAYSCALE,
  #     size: 150
  #   )

  #   # Save the QR code as an image file
  #   # File.open("./app/assets/images/qrcode-#{@ordonnance.ordonnance_number}.png", 'wb') do |file|
  #   #   file.write(qrcode_as_svg)
  #   # end


  #   # file = URI.open("https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/1200px-NES-Console-Set.jpg")
  #   # article = Article.new(title: "NES", body: "A great console")
  #   # article.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  #   # article.save

  #   Cloudinary::Uploader.upload(qrcode_as_svg)

  #   # Update the is_used flag
  #   @ordonnance.update(qr_generated: true)

  #   # Redirect or render as needed
  #   respond_to do |format|
  #     format.html { redirect_to appointment_ordonnance_path(appointment_id: @ordonnance.appointment.id, id: @ordonnance.id) }
  #     format.json { render json: { qr_code_url: view_context.image_url("qrcode-#{ordonnance_number}.png") } }
  #   end
  # end

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
