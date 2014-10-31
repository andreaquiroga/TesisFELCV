class AddFileToConclusion < ActiveRecord::Migration
  def change
  	add_attachment :conclusions, :conclusion_signed
  	add_column :conclusions, :sign, :boolean
  end
end
