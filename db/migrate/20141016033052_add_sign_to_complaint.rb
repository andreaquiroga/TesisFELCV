class AddSignToComplaint < ActiveRecord::Migration
  def change
  	add_column :complaints, :sign, :boolean
  end
end
