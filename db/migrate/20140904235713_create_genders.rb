class CreateGenders < ActiveRecord::Migration
  def change
    create_table :genders do |t|
      t.string :text
      t.timestamps
    end
  end
end
