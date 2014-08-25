class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
	  t.string :code
      t.string :init_date
      t.string :end_date
      t.references :user, index: true
      t.timestamps
    end
  end
end
