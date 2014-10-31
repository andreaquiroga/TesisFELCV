class Conclusion < ActiveRecord::Base
  	validates :antecedents, :direct_action, :police_actions, :request,
	:presence => {:message => " no puede ser nulo."}
	has_attached_file :conclusion_signed,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_options => {:path => proc{|style| "conclusions/#{id}"}}

    validates_attachment :conclusion_signed, content_type: { content_type: ["application/pdf"] }
    belongs_to :case 

    def self.generate_pdf(conclusion_id)
		complaint =  Conclusion.find(conclusion_id)
		my_case = Case.find(complaint.case_id)
		people = Link.where(:case_id => my_case.id) 
		user = User.find(my_case.user_id)
		pdf = Prawn::Document.new
		pdf.image "app/assets/images/bpaf.png", :at => [30,750], :scale => 0.4
		pdf.image "app/assets/images/police.jpg", :at => [450,750], :scale => 0.2
		pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.text "INFORME POLICIAL", :size => 24, :style => :bold, :align => :center
	    pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.table([["DATOS GENERALES\nDivision: FELCV\nCodigo del caso: "+my_case.code.to_s+"\nFecha de inicio del caso: "+my_case.init_date+"\nOficial investigador: "+user.grade+" "+user.name+" "+user.paternal_last_name]], :width => 500,:cell_style => { size: 14 })
	    pdf.text " "
	    pdf.text "DATOS", :size => 16, :style => :bold
	    pdf.text "Antecedentes: ", :size => 12, :spacing => 4, :style=>:bold
	    pdf.text "#{complaint.antecedents.to_s}", :size => 12
	    if complaint.direct_action!=nil
		    pdf.text "Accion Directa: ", :size => 12, :spacing => 4, :style => :bold
		    pdf.text " #{complaint.direct_action}", :size => 12
		end
	    pdf.text "Acciones Policiales: ", :size => 12, :spacing => 4, :style => :bold
	    pdf.text "#{complaint.police_actions.to_s} ", :size => 12
	    pdf.text "Petitorio: ", :size => 12, :spacing => 4, :style => :bold
	    pdf.text "#{complaint.request} ", :size => 12
	      pdf.text " "
	      pdf.text " "
	      pdf.text " "
	      pdf.text "...................................."
	      pdf.text "#{user.grade} #{user.name} #{user.paternal_last_name} #{user.maternal_last_name}", :size => 12, :spacing => 4
	    return pdf
	end

	def self.signing_conclusion(conclusion, complaint_sign, cert, private_key)
		pdf = Origami::PDF.read(conclusion.id.to_s)
		page = pdf.get_page(1)
    	sigannot = Origami::Annotation::Widget::Signature.new
	    sigannot.Rect = Origami::Rectangle[:llx => 89.0, :lly => 386.0, :urx => 190.0, :ury => 353.0]
	    page.add_annot(sigannot)
	    user = User.find(conclusion.case.user_id)
	      pdf.sign(cert, private_key, 
	        :method => 'adbe.pkcs7.sha1',
	        :annotation => sigannot, 
	        :location => "Bolivia", 
	        :contact => user.email, 
	        :reason => "Proof of Concept"
	      )
	      
	      pdf.save("app/assets/images/c_"+conclusion.id.to_s+".pdf")	      
	  end

end
