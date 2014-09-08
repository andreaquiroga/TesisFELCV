class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :place
      t.references :direct_action, index: true
      t.timestamps
    end
  end
end
