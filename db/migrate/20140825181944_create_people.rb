class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :ci
      t.string :name
      t.string :paternal_last_name
      t.string :maternal_last_name
      t.string :civil_status
      t.string :nationality
      t.string :natural_of
      t.string :work
      t.string :work_phone
      t.string :ocupation
      t.string :gender
      t.string :phone
      t.string :mobile
      t.date :birthdate
      t.integer :location_home_id, :reference=>"location"
      t.integer :location_work_id, :reference=>"location"
      t.timestamps
    end
  end
end
