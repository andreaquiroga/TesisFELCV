class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.string :resume
      t.boolean :sign
      t.references :case, index: true
      t.timestamps
    end
  end
end
