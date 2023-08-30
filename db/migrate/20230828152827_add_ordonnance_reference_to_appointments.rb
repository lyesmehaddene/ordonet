class AddOrdonnanceReferenceToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointments, :ordonnance, null: true, foreign_key: true
  end
end
