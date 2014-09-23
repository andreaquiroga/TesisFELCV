class Conclusion < ActiveRecord::Base
  	validates :antecedents, :direct_action, :police_actions, :request,
	:presence => {:message => " no puede ser nulo."}
    belongs_to :case 
end
