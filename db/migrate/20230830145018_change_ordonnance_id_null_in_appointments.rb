class ChangeOrdonnanceIdNullInAppointments < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :ordonnance_id, :integer, null: true
  end
end
