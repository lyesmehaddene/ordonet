class CreateOrdonnances < ActiveRecord::Migration[7.0]
  def change
    create_table :ordonnances do |t|
      t.references :appointment , null: false, foreign_key: true
      t.boolean :is_signed
      t.boolean :is_sent
      t.timestamps
    end
  end
end
