# Preview all emails at http://localhost:3000/rails/mailers/pdf_mailer
class PdfMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/pdf_mailer/post_appointment
  def post_appointment
    PdfMailer.post_appointment
  end

end
