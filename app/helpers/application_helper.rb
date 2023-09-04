module ApplicationHelper
  def qr_code_image_path(ordonnance)
    image_filename = "qrcode-#{ordonnance.ordonnance_number}.png"
    image_path = Rails.root('tmp', image_filename)

    if File.exist?(image_path)
      image_filename
    else
      '' # Return an empty string when no QR code file exists
    end
  end
end
