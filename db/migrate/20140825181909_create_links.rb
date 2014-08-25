class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :role
      t.references :case, index: true
      t.references :person, index: true
      t.timestamps
    end
  end
end
