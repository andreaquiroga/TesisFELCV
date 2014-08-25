class Link < ActiveRecord::Base
	:role
	belongs_to :case
	belongs_to :person
end
