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

	def self.search(search)
	  if search
	    find(:all, :conditions => ['code LIKE ?', "%#{search}%"])
	  else
	    find(:all)
	  end
	end

	def self.advanced_search_nature(nature)
	  if nature
		find(:all, :joins => :complaint,:conditions =>['nature LIKE ?', "%#{nature}%"])
	  else
	  	find(:all)
      end
	end

	def self.advanced_search_researcher(researcher)
	  if researcher
		find(:all, :joins => {:user=>:official},:conditions =>['name LIKE ?', "%#{researcher}%"])
	  else
	  	find(:all)
      end
	end

	def self.has_complaint
	end

end
