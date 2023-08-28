class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :specialty
      t.string :accreditation_number
      t.timestamps
    end
  end
end
