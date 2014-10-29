require 'prawn'
require 'origami'
require 'openssl'
require 'tempfile'
require 'open-uri'
require 'pdf/reader'



class ComplaintsController < ApplicationController
  before_action :set_complaint, only: [:show, :edit, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /complaints
  # GET /complaints.json
  def index
    @complaints = Complaint.all
  end
 
  # GET /complaints/1
  # GET /complaints/1.json
  def show
     @case = Case.find(@complaint.case_id)
     @links = Link.where(:case_id=>@case.id)
     @cases = Array.new
     news = Array.new
     @links.each do |l|
        ls = Link.where(:person_id=>l.person_id)
        ls.each do |li|
          news.push(li)
        end
     end
     news.each do |n|
        ca = Case.find(n.case_id)
        @cases.push(ca)
     end
     @cases = @cases.uniq
     @cases.delete(@case)
  end

  # GET /complaints/new
  def new
    @complaint = Complaint.new
    @complaint.case_id=params[:case_id]
    @case = Case.find(params[:case_id])
  end

  # GET /complaints/1/edit
  def edit
    @case=Case.find(@complaint.case_id)
  end

  #GET /complaints/private_key
  def private_key
    @case = Case.find(params[:id])
    @complaint = Complaint.where(:case_id=>params[:id]).first
    @user=User.find(current_user.id)
  end

  def sign_complaint
    @file_key = params[:key].read
    @private_key = OpenSSL::PKey::RSA.new @file_key, params[:pass_phrase]
    @cs = Complaint.generate_pdf(params[:complaint_id])
    @complaint = Complaint.find(params[:complaint_id])
    @case = Case.find(@complaint.case_id)
    @cs.render_file @complaint.id.to_s
    @cert = OpenSSL::X509::Certificate.new(open("C:/Users/Andrea/Dropbox/Aplicaciones/felcv/"+(current_user.upload_cert.path).to_s))
    Complaint.signing_complaint(@complaint, @cs, @cert, @private_key)
    @file = File.open("D:/tesis/felcv/app/assets/images/"+@complaint.id.to_s+".pdf")  
    @complaint.complaint_signed = @file
    if @complaint.complaint_signed_content_type == 'application/octet-stream'
      @complaint.complaint_signed_content_type = 'application/pdf'
    end
    @complaint.sign = true
    @complaint.save
    redirect_to case_path(@complaint.id)
  end

  def save_complaint_pdf
    @complaint = Complaint.find(params[:complaint_id])
    @complaint.complaint_signed = params[:pdf]
    @complaint.save
  end

  # POST /complaints
  # POST /complaints.json
  def create
    @complaint = Complaint.new(complaint_params)
    @case = Case.find(@complaint.case_id)
    respond_to do |format|
      if @complaint.save
        format.html { redirect_to complaint_path(@complaint.id), notice: 'Denuncia creada.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /complaints/1
  # PATCH/PUT /complaints/1.json
  def update
    @complaint = Complaint.find(params[:complaint][:id])
    respond_to do |format|
      if @complaint.update(complaint_params)
        format.html { redirect_to complaint_path(@complaint.id), notice: 'Denuncia modificada.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /complaints/1
  # DELETE /complaints/1.json
  def destroy
    @complaint.destroy
    respond_to do |format|
      format.html { redirect_to complaints_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complaint
      @complaint = Complaint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def complaint_params
      params.require(:complaint).permit(:fact_date, :place, :nature, :aggressor_relation, :fact_time, :cincunstancial_relation, :case_id)
    end
end
