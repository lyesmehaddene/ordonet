class PdfCreationService

  def self.create_pdf(current_user, appointment)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{current_user.first_name}_#{current_user.last_name}-#{appointment.patient.user.first_name}_#{appointment.patient.user.last_name}_#{Date.today}}",
              template: "ordonnances/show.html.erb"
      end
    end
  end
end
