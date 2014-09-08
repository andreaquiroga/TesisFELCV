class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.string :answer
      t.references :interview, index: true
      t.timestamps
    end
  end
end
