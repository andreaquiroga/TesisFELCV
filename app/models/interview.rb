class Interview < ActiveRecord::Base
	:resume
	:sign
	has_many :questions

	has_attached_file :interview_signed,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_options => {:path => proc{|style| "interviews/#{id}"}}

    validates_attachment :interview_signed, content_type: { content_type: ["application/pdf"] }

	belongs_to :case

	def self.generate_pdf(interview_id)
		interview = Interview.find(interview_id)
		my_case=Case.find(interview.case_id)
		report=Complaint.where(:case_id=>my_case.id).first
		user=User.find(my_case.user_id)
		pdf = Prawn::Document.new
		pdf.image "app/assets/images/bpaf.png", :at => [30,750], :scale => 0.4
		pdf.image "app/assets/images/police.jpg", :at => [450,750], :scale => 0.4
		pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.text "ENTREVISTA INFORMATIVA POLICIAL", :size => 24, :style => :bold, :align => :center
	    pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.text " ", :size => 20, :style => :bold, :align => :center
	    pdf.table([["DATOS GENERALES\nDivision: FELCV\nNro. de caso: "+my_case.code+"\nOficial encargada: "+user.grade+" "+user.name+" "+user.paternal_last_name]], :width => 500,:cell_style => { size: 12 })
	    #pdf.text "Codigo: #{my_case.code}", :size => 12, :spacing => 4
	    pdf.text " "
	    pdf.text "DATOS DEL HECHO", :size => 18, :style => :bold
	    pdf.text "Fecha Del Hecho: ", :size => 12, :spacing => 4, :style=>:bold
	    pdf.text "#{report.fact_date.to_s}", :size => 12
	    pdf.text "Hora Del Hecho: ", :size => 12, :spacing => 4, :style => :bold
	    pdf.text "#{report.fact_time.to_s} ", :size => 12
	    pdf.text "Lugar: ", :size => 12, :spacing => 4, :style => :bold
	    pdf.text "#{report.place} ", :size => 12
	    pdf.text "Relacion Circunstalcial: ", :size => 12, :spacing => 4, :style => :bold
	    pdf.text " #{report.cincunstancial_relation}", :size => 12
	    pdf.text "Naturaleza: ", :size => 12, :spacing => 4, :style => :bold
	    pdf.text "#{report.nature}", :size => 12
	    pdf.text " "
	    pdf.text " "
	    pdf.text "#{interview.resume}", :size => 12, :style => :bold
	    pdf.text " "
	    interview.questions.each do |p|
	      pdf.text "Pregunta.- #{p.text}", :size => 12, :style => :bold
	      pdf.text " "
	      pdf.text "Respuesta.- #{p.answer}", :size => 12, :spacing => 4
	      pdf.text " "
	      pdf.text " "
	    end
	    pdf.text " "
	      pdf.text " "
	      pdf.text " "
	      pdf.text " "
	      pdf.text " "
	      pdf.text " "
	      pdf.text " "
	      pdf.text "...................................."
	      pdf.text "#{user.grade} #{user.name} #{user.paternal_last_name} #{user.maternal_last_name}", :size => 12, :spacing => 4
	    return pdf
	end

	def self.signing_interview(conclusion, complaint_sign, cert, private_key)
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
	      
	      pdf.save("app/assets/images/i_"+conclusion.id.to_s+".pdf")	      
	  end
end
