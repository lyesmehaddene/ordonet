class AddOrdonnanceNumberToOrdonnances < ActiveRecord::Migration[7.0]
  def change
    add_column :ordonnances, :ordonnance_number, :integer
  end
end
