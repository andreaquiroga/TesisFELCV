class AddColumnsToUser < ActiveRecord::Migration
  def change
  	  add_column :users, :ci, :integer
  	  add_column :users, :name, :string
  	  add_column :users, :paternal_last_name, :string
  	  add_column :users, :maternal_last_name, :string
  	  add_column :users, :grade, :string
  	  add_column :users, :address, :string
  	  add_column :users, :phone, :string
  	  add_column :users, :mobile, :string
  	  add_column :users, :admission_date, :string
  	  add_column :users, :birthdate, :string
  	  add_column :users, :last_work, :string
	  add_column :users, :status, :string
  end
end
