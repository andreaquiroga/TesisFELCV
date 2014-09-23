class AddTurnToUser < ActiveRecord::Migration
  def change
    add_column :users, :turn, :string
  end
end
