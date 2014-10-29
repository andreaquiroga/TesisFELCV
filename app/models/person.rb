class Person < ActiveRecord::Base
	validates :ci,
        	:presence  => { :message => " El campo no puede ser nulo" },
        	:numericality => {:only_integer => true, :greater_than_or_equal_to => 99999, :message => "El dato debe ser un numero de la menos 5 digitos"},
          :uniqueness  => { :message => " el CI ya esta registrado" }
     validates :name, :paternal_last_name,
           :presence  => { :message => "El campo no puede ser nulo" },
           :length => {:minimum => 2, :message => "la longitud minima es de dos"}
     :maternal_last_name
#     :work 
#     :work_phone
     :mobile
#     :ocupation
     
     validates :civil_status, :nationality, :natural_of,
           :presence  => { :message => "El campo no puede ser nulo" },
      	   :length => {:minimum => 2, :message => "la longitud minima es de dos"}      
      validates :gender, :birthdate,
          :presence  => { :message => "El campo no puede ser nulo" }
      validates :phone,
          :presence  => { :message => " El campo no puede ser nulo" },
    	     :numericality => {:only_integer => true, :greater_than_or_equal_to => 999999, :message => "El dato debe ser un numero de la menos 7 digitos"}      
      
      has_many :links
      belongs_to :home, :class_name=>"Location", :foreign_key=>'location_home_id'
      belongs_to :loc_work, :class_name=>"Location", :foreign_key=>'location_work_id'
      
end
