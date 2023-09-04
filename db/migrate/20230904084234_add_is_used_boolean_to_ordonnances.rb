class AddIsUsedBooleanToOrdonnances < ActiveRecord::Migration[7.0]
  def change
    add_column :ordonnances, :is_used, :boolean, default: false
  end
end
