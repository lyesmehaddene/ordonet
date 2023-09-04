class AddQrGeneratedToOrdonnances < ActiveRecord::Migration[7.0]
  def change
    add_column :ordonnances, :qr_generated, :boolean, default: false
  end
end
