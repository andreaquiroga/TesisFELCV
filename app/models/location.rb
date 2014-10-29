class Location < ActiveRecord::Base
	:latitude
	:longitude
	:place
	:address
	:number
	has_many :people
	has_one :station
end
