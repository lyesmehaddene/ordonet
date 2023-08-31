class AddCommentaryToOrdoMedications < ActiveRecord::Migration[7.0]
  def change
    add_column :ordo_medications, :commentary, :text
  end
end
