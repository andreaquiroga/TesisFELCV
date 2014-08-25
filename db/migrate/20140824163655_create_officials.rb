class CreateOfficials < ActiveRecord::Migration
  def change
    create_table :officials do |t|
      t.integer :ci
	  t.string :name
	  t.string :paternal_last_name
	  t.string :maternal_last_name
	  t.string :grade
	  t.string :address
	  t.string :phone
	  t.string :mobile
	  t.string :admission_date
	  t.string :birthdate
	  t.string :last_work
	  t.references :user, index: true
      t.timestamps
    end
  end
end
