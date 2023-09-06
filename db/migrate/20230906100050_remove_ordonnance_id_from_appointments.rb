class RemoveOrdonnanceIdFromAppointments < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :ordonnance_id, :integer
  end
end
