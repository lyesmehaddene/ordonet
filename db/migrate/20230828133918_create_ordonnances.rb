class CreateOrdonnances < ActiveRecord::Migration[7.0]
  def change
    create_table :ordonnances do |t|
      t.boolean :is_signed
      t.boolean :is_sent
      t.timestamps
    end
  end
end
