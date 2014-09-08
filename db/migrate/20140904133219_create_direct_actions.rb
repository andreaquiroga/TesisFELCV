class CreateDirectActions < ActiveRecord::Migration
  def change
    create_table :direct_actions do |t|
      t.string :police_name
      t.string :police_station
      t.string :police_ci
      t.string :police_grade
      t.string :station_zone
      t.string :station_acronym
      t.string :police_phone
      t.date :fact_date
      t.string :place
      t.time :fact_time
      t.string :nature
      t.string :cincunstancial_relation
      t.references :case, index: true
      t.timestamps
    end
  end
end
