class AddAppointmentReferenceToOrdonnances < ActiveRecord::Migration[7.0]
  def change
    add_reference :ordonnances, :appointment, null: false, foreign_key: true
  end
end
