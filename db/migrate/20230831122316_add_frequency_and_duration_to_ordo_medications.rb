class AddFrequencyAndDurationToOrdoMedications < ActiveRecord::Migration[7.0]
  def change
    add_column :ordo_medications, :frequency, :integer
    add_column :ordo_medications, :duration, :integer
  end
end
