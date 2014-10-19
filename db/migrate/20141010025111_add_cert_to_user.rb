class AddCertToUser < ActiveRecord::Migration
  def change
  	add_attachment :users, :upload_cert
  end
end
