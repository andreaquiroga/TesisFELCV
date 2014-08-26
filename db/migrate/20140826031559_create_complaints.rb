class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.date :fact_date
      t.string :place
      t.time :fact_time
      t.string :cincunstancial_relation
      t.string :nature
      t.string :aggressor_relation
      t.references :case, index: true
      t.timestamps
    end
  end
end
