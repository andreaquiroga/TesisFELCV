class AddTurnToUser < ActiveRecord::Migration
  def change
    add_column :users, :turn, :integer
  end
end
