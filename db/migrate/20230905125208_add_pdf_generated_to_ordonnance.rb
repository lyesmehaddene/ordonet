class AddPdfGeneratedToOrdonnance < ActiveRecord::Migration[7.0]
  def change
    add_column :ordonnances, :pdf_generated, :boolean, default: false
  end
end
