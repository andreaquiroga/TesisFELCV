require 'prawn'
require 'origami'
require 'openssl'
require 'fileutils'
require 'prawn/table'


class Complaint < ActiveRecord::Base
	validates :fact_date, :place, :fact_time, :cincunstancial_relation, :nature, :aggressor_relation,
	:presence  => { :message => " no puede ser nulo" }

	has_attached_file :complaint_signed,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_options => {:path => proc{|style| "complaints/#{id}"}}

    validates_attachment_presence :complaint_signed
    validates_attachment_content_type :complaint_signed, :content_type => /application\/pdf/

	belongs_to :case

	def self.generate_pdf(complaint_id)
		complaint =  Complaint.find(complaint_id)
		my_case = Case.find(complaint.case_id)
		people = Link.where(:case_id => my_case.id) 
		user = User.find(my_case.user_id)
		pdf = Prawn::Document.new
		pdf.image "app/assets/images/bpaf.png", :at => [30,750], :scale => 0.4
		pdf.image "app/assets/images/police.jpg", :at => [450,750], :scale => 0.2
		pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.text "ACTA DE DENUNCIA VERBAL", :size => 24, :style => :bold, :align => :center
	    pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.table([["DATOS GENERALES\nDivision: FELCV\nCodigo del caso: "+my_case.code.to_s+"\nFecha de inicio del caso: "+my_case.init_date+"\nOficial investigador: "+user.grade+" "+user.name+" "+user.paternal_last_name]], :width => 500,:cell_style => { size: 14 })
	    pdf.text " "
	    pdf.text "DATOS DEL HECHO", :size => 16, :style => :bold
	    pdf.text "Fecha Del Hecho: ", :size => 12, :spacing => 4, :style=>:bold
	    pdf.text "#{complaint.fact_date.to_s}", :size => 12
	    pdf.text "Hora Del Hecho: ", :size => 12, :spacing => 4, :style => :bold
	    pdf.text "#{complaint.fact_time.strftime("%H:%M").to_s} ", :size => 12
	    pdf.text "Lugar: ", :size => 12, :spacing => 4, :style => :bold
	    pdf.text "#{complaint.place} ", :size => 12
	    pdf.text "Relacion Circunstancial: ", :size => 12, :spacing => 4, :style => :bold
	    pdf.text " #{complaint.cincunstancial_relation}", :size => 12
	    pdf.text "Naturaleza: ", :size => 12, :spacing => 4, :style => :bold
	    pdf.text "#{complaint.nature}", :size => 12
	    pdf.text "Relacion de la victima con el agresor : ", :size => 12, :spacing => 4, :style => :bold
	    pdf.text "#{complaint.aggressor_relation}", :size => 12
	    pdf.text " "
	    pdf.text " "
	    people.each do |p|
	      pdf.text "DATOS PERSONALES: #{p.role}", :size => 16, :style => :bold
	      pdf.text " "
	      if p.person.maternal_last_name!=nil
	      	pdf.text "Nombre: #{p.person.name} #{p.person.paternal_last_name} #{p.person.maternal_last_name} ", :size => 12
	      else
	      	pdf.text "Nombre: #{p.person.name} #{p.person.paternal_last_name} ", :size => 12
	      end
	      pdf.text "CI: #{p.person.ci}", :size => 12, :spacing => 4
	      pdf.text "Genero: #{p.person.gender}", :size => 12, :spacing => 4
	      pdf.text "Nacimiento: #{p.person.birthdate}", :size => 12, :spacing => 4
	      pdf.text "Estado civil: #{p.person.civil_status}", :size => 12, :spacing => 4
	      pdf.text "Nacionalidad: #{p.person.nationality}", :size => 12, :spacing => 4
	      pdf.text "Natural de: #{p.person.natural_of}", :size => 12, :spacing => 4
	      pdf.text "Telefono: #{p.person.phone}", :size => 12, :spacing => 4
	      pdf.text "Ocupacion: #{p.person.ocupation}", :size => 12, :spacing => 4
	      @location_home=Location.find(p.person.location_home_id)
	      pdf.text "Direccion: #{@location_home.address}", :size => 12, :spacing => 4	      
	      pdf.text " "
	      pdf.text " "
	    end
	    pdf.text " "
	      pdf.text " "
	      pdf.text " "
	      pdf.text " "
	      pdf.text "...................................."
	      pdf.text "#{user.grade} #{user.name} #{user.paternal_last_name} #{user.maternal_last_name}", :size => 12, :spacing => 4
	    return pdf
	end

	def self.signing_complaint(complaint, complaint_sign, cert, private_key)
		pdf = Origami::PDF.read(complaint.id.to_s)
		#pdf = Origami::PDF.new(complaint_sign)
		page = pdf.get_page(1)
    	sigannot = Origami::Annotation::Widget::Signature.new
	    sigannot.Rect = Origami::Rectangle[:llx => 89.0, :lly => 386.0, :urx => 190.0, :ury => 353.0]
	    page.add_annot(sigannot)
	    user = User.find(complaint.case.user_id)
	      pdf.sign(cert, private_key, 
	        :method => 'adbe.pkcs7.sha1',
	        :annotation => sigannot, 
	        :location => "Bolivia", 
	        :contact => user.email, 
	        :reason => "Proof of Concept"
	      )
	      #send_file " app/assets/images/"+complaint.id.to_s+".pdf", :filename => "denuncia"+complaint.case_id.to_s+".pdf", :type => "application/pdf"
	      pdf.save("app/assets/images/"+complaint.id.to_s+".pdf")

	      
	      #filename = "app/reports/denuncia"+complaint.case_id.to_s+"_signed.pdf"
	      
	  end
		
end
