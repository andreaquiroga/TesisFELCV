class Item < ActiveRecord::Base
	validates :name, :description, :place,
	:presence => {:message => " no puede ser vacio"}
	belongs_to :direct_action
end
