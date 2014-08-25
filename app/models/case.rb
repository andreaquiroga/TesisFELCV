class Case < ActiveRecord::Base
	validates :init_date,
	:presence  => { :message => "El campo es necesario no puede ser nulo" }
	
	:end_date
	validates :code,
	
	:presence  => { :message => "No puede ser nulo" },
	:length => {:minimum => 2, :message=>"La longitud minima es dos digitos"}
	belongs_to :user
	has_many :links
end
