class Official < ActiveRecord::Base
	validates :ci,
		:presence  => { :message => " es requerido " },
		:length => {:minimum => 5, :message => "tiene como longitud minina: 5"},
		:length => {:maximum => 10, :message => "tiene como maximo 10 digitos"},
		:uniqueness  => { :message => "existente, elija otro " },
		:numericality => {:only_integer => true, :message => "debe ser un numero"}
	#	:cert
	#	:private_key

	validates :name, :paternal_last_name, :grade, :address, :last_work,
		:presence  => { :message => "es requerido " },
		:length => {:minimum => 1, :message => "tiene como longitud minina: 1 "}
	
	:maternal_last_name

	validates :phone,
		:presence  => { :message => "es requerido " },
		:length => {:minimum => 6, :message => "tiene como longitud minina: 6 "},
		:numericality => {:only_integer => true, :message => "debe ser un numero"} 
		
	validates :mobile,
		:presence  => { :message => "es requerido " },
		:length => {:minimum => 8,  :message => "tiene como longitud minina: 8 "},
		:numericality => {:only_integer => true, :message => "debe ser un numero"}

	validates :admission_date,
		:presence  => { :message => "es requerido " }

	validates :birthdate,
		:presence  => { :message => "es requerido " }
	
	belongs_to :user
end
