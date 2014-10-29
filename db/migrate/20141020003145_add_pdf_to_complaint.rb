class AddPdfToComplaint < ActiveRecord::Migration
  def change
  	add_attachment :complaints, :complaint_signed
  end
end
