class Station < ActiveRecord::Base
	validates :name,
	:presence  => { :message => "el campo es requerido" },
	:length => {:minimum => 2, :message => "longitud minima: 2"}
	:phone
	belongs_to :location
	has_many :users
end
