class Case < ActiveRecord::Base
	validates :init_date,
	:presence  => { :message => " es necesario no puede ser nulo" }
	
	:end_date
	validates :code,
	:presence  => { :message => " no puede ser nulo" },
	:length => {:minimum => 2, :message=>" longitud minima es dos digitos"}

	belongs_to :user
	has_many :links
	has_one :complaint
	has_one :interview
	has_one :direct_action
	has_one :conclusion

	def self.search(search)
	  if search
	    find(:all, :conditions => ['code LIKE ?', "%#{search}%"])
	  else
	    find(:all)
	  end
	end

	def self.advanced_search_nature(nature)
	  if nature.blank?
		find(:all)
	  else
	  	find(:all, :joins => :complaint,:conditions =>['nature LIKE ?', "%#{nature}%"])
      end
	end

	def self.advanced_search_researcher(researcher)
	  if researcher.blank?
		find(:all)
	  else
	  	find(:all, :joins => :user,:conditions =>['name LIKE ?', "%#{researcher}%"])
      end
	end

	def self.advanced_search_person(person)
	  if person.blank?
		find(:all)
	  else
	  	find(:all, :joins => {:links=>:person},:conditions =>['name LIKE ?', "%#{person}%"])
      end
	end

	def self.has_complaint(id)
	  Complaint.where(:case_id=>id)
	end

end
