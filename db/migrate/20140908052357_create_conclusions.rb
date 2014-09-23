class CreateConclusions < ActiveRecord::Migration
  def change
    create_table :conclusions do |t|
      t.string :antecedents
      t.string :direct_action
      t.string :police_actions
      t.string :request
      t.references :case, index: true
      t.timestamps
    end
  end
end
