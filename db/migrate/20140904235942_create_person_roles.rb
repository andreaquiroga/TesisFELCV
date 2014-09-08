class CreatePersonRoles < ActiveRecord::Migration
  def change
    create_table :person_roles do |t|
      t.string :text
      t.timestamps
    end
  end
end
