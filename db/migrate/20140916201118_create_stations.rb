class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :phone
      t.integer :location_id, :reference=>"location"
      t.timestamps
    end
  end
end
