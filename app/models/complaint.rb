class Complaint < ActiveRecord::Base
	validates :fact_date, :place, :fact_time, :cincunstancial_relation, :nature, :aggressor_relation,
	:presence  => { :message => " no puede ser nulo" }
	belongs_to :case
end
