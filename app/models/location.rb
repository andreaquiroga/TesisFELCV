class Location < ActiveRecord::Base
	:latitude
	:longitude
	:place
	:address
	:number
	has_many :person
	#has_one :station
end
