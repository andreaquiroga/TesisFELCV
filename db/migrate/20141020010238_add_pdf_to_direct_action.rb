class AddPdfToDirectAction < ActiveRecord::Migration
  def change
  	add_attachment :direct_actions, :direct_action_signed
  	add_column :direct_actions, :sign, :boolean
  end
end
