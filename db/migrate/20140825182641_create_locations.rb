class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.integer :number
      t.string :place
      t.timestamps
    end
  end
end
