class DirectAction < ActiveRecord::Base
	validates :police_name, :police_station, :police_ci, :police_grade, :station_zone,
	:presence  => { :message => " no puede ser nulo" }
	:police_phone
	:station_acronym
	validates :fact_date, :fact_time, :place, :nature, :cincunstancial_relation,
	:presence => { :message => "no puede ser vacio"}
	belongs_to :case
	has_many :items
end
