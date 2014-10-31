class ConclusionsController < ApplicationController
  before_action :set_conclusion, only: [:show, :edit, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /conclusions
  # GET /conclusions.json
  def index
    @conclusions = Conclusion.all
  end

  # GET /conclusions/1
  # GET /conclusions/1.json
  def show
    @case = Case.find(@conclusion.case_id)
  end

  # GET /conclusions/new
  def new
    @conclusion = Conclusion.new
    @conclusion.case_id = params[:case_id]
    @case = Case.find(params[:case_id])
  end

  # GET /conclusions/1/edit
  def edit
    @case = Case.find(@conclusion.case_id)
  end

  def private_key
    @case = Case.find(params[:id])
    @conclusion = Conclusion.where(:case_id=>params[:id]).first
    @user=User.find(current_user.id)
  end

  def sign_conclusion
    @file_key = params[:key].read
    @private_key = OpenSSL::PKey::RSA.new @file_key, params[:pass_phrase]
    @cs = Conclusion.generate_pdf(params[:conclusion_id])
    @conclusion = Conclusion.find(params[:conclusion_id])
    @case = Case.find(@conclusion.case_id)
    @cs.render_file @conclusion.id.to_s
    if current_user.upload_cert ==nil
      flash[:warning] = "No se puede encontrar su Certificado Digital"
      redirect_to case_path(@case.id)
    end
    @cert = OpenSSL::X509::Certificate.new(open("C:/Users/Andrea/Dropbox/Aplicaciones/felcv/"+(current_user.upload_cert.path).to_s))
    Conclusion.signing_conclusion(@conclusion, @cs, @cert, @private_key)
    @file = File.open("D:/tesis/felcv/app/assets/images/c_"+@conclusion.id.to_s+".pdf")  
    @conclusion.conclusion_signed = @file
    if @conclusion.conclusion_signed_content_type == 'application/octet-stream'
      @conclusion.conclusion_signed_content_type = 'application/pdf'
    end
    @conclusion.sign = true
    @conclusion.save
    redirect_to conclusion_path(@conclusion.id)
  end

  # POST /conclusions
  # POST /conclusions.json
  def create
    @conclusion = Conclusion.new(conclusion_params)
    @case = Case.find(@conclusion.case_id)
    respond_to do |format|
      if @conclusion.save
        format.html { redirect_to @conclusion, notice: 'Se almaceno la conclusion correctamente.' }
        format.json { render action: 'show', status: :created, location: @conclusion }
      else
        format.html { render action: 'new' }
        format.json { render json: @conclusion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conclusions/1
  # PATCH/PUT /conclusions/1.json
  def update
    @conclusion = Conclusion.find(params[:conclusion][:id])
    respond_to do |format|
      if @conclusion.update(conclusion_params)
        format.html { redirect_to @conclusion, notice: 'Conclusion editada correctamente.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @conclusion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conclusions/1
  # DELETE /conclusions/1.json
  def destroy
    @conclusion.destroy
    respond_to do |format|
      format.html { redirect_to conclusions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conclusion
      @conclusion = Conclusion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conclusion_params
      params.require(:conclusion).permit(:antecedents, :direct_action, :police_actions, :request, :case_id)
    end
end
