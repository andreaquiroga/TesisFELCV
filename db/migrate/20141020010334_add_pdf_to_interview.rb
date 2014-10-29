class AddPdfToInterview < ActiveRecord::Migration
  def change
  	add_attachment :interviews, :interview_signed
  end
end
