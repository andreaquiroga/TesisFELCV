class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :label
      t.decimal :porcentage
      t.references :report, index: true
      t.timestamps
    end
  end
end
