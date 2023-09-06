class PdfMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.pdf_mailer.post_appointment.subject
  #
  def post_appointment(appointment, ordonnance, patient)
    @ordonnance = ordonnance
    @appointment = appointment
    # @pdf_link = create_pdf_appointment_ordonnance_path(appointment_id: @appointment.id, id: @ordonnance.id, format: :pdf)
    @greeting = "Bonjour #{patient.user.first_name} #{patient.user.last_name}"
    mail to: patient.user.email, subject: "Votre ordonnance"
  end
end
