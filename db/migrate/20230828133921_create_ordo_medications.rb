class CreateOrdoMedications < ActiveRecord::Migration[7.0]
  def change
    create_table :ordo_medications do |t|
      t.references :ordonnance, null: false, foreign_key: true
      t.references :medication, null: false, foreign_key: true
      t.timestamps
    end
  end
end
