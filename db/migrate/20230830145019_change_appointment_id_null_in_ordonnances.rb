class ChangeAppointmentIdNullInOrdonnances < ActiveRecord::Migration[7.0]
  def change
    change_column :ordonnances, :appointment_id, :integer, null: true
  end
end
