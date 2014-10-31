class DirectActionsController < ApplicationController
  before_action :set_direct_action, only: [:show, :edit, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /direct_actions
  # GET /direct_actions.json
  
  def index
    @direct_actions = DirectAction.all
  end

  # GET /direct_actions/1
  # GET /direct_actions/1.json
  def show
    @direct_action = DirectAction.find(params[:id])
    @case = Case.find(@direct_action.case_id)
  end

  # GET /direct_actions/new
  def new
    @direct_action = DirectAction.new
    @direct_action.case_id = params[:case_id]
    @case = Case.find(params[:case_id])
    @item = Item.new
  end

  # GET /direct_actions/1/edit
  def edit
    @direct_action = DirectAction.find(params[:id])
    @case = Case.find(@direct_action.case_id)
    @item = Item.new
  end

  def private_key
    @case = Case.find(params[:id])
    @direct_action = DirectAction.where(:case_id=>params[:id]).first
    @user=User.find(current_user.id)
  end

  def sign_direct_action
    @file_key = params[:key].read
    @private_key = OpenSSL::PKey::RSA.new @file_key, params[:pass_phrase]
    @cs = DirectAction.generate_pdf(params[:direct_action_id])
    @direct_action = DirectAction.find(params[:direct_action_id])
    @case = Case.find(@direct_action.case_id)
    @cs.render_file @direct_action.id.to_s
    if current_user.upload_cert == nil
      flash[:warning] = "No se puede encontrar su Certificado Digital"
      redirect_to case_path(@case.id)
    end
    @cert = OpenSSL::X509::Certificate.new(open("C:/Users/Andrea/Dropbox/Aplicaciones/felcv/"+(current_user.upload_cert.path).to_s))
    DirectAction.signing_direct_action(@direct_action, @cs, @cert, @private_key)
    @file = File.open("D:/tesis/felcv/app/assets/images/d_a_"+@direct_action.id.to_s+".pdf")  
    @direct_action.direct_action_signed = @file
    if @direct_action.direct_action_signed_content_type == 'application/octet-stream'
      @direct_action.direct_action_signed_content_type = 'application/pdf'
    end
    @direct_action.sign = true
    @direct_action.save
    redirect_to direct_action_path(@direct_action.id)
  end

  

  # POST /direct_actions
  # POST /direct_actions.json
  def create
    @direct_action = DirectAction.new(direct_action_params)
    @case = Case.find(@direct_action.case_id)
    @item = Item.new
    respond_to do |format| 
      if @direct_action.save
        @item = Item.new(item_params)
        @item.direct_action_id = @direct_action.id
        if @item.save
          format.html { redirect_to edit_direct_action_path(@direct_action.id), notice: '' }
          format.json { render action: 'show', status: :created, location: @direct_action }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @direct_action.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_item
    @item = Item.new(item_params)
    @item.direct_action_id = params[:id]
    if @item.save
      #redirect_to edit_direct_action_path(@direct_action.id)
      redirect_to root_path
    end
  end 

  # PATCH/PUT /direct_actions/1
  # PATCH/PUT /direct_actions/1.json
  def update
    @direct_action = DirectAction.find(params[:direct_action][:id])
    @case = Case.find(@direct_action.case_id)
    respond_to do |format|
      if @direct_action.update(direct_action_params)
        if params[:add]
          @item = Item.new(item_params)
          @item.direct_action_id = @direct_action.id
          if @item.save
            format.html { redirect_to edit_direct_action_path(@direct_action.id), notice: '' }
            format.json { render action: 'show', status: :created, location: @direct_action }
          else
            format.html { render action: 'edit' }
            format.json { render json: @direct_action.errors, status: :unprocessable_entity }
          end
        else
          if params[:edit]
            format.html { redirect_to edit_direct_action_path(@direct_action.id), notice: '' }
            format.json { render action: 'show', status: :created, location: @direct_action }
          else
            format.html { redirect_to direct_action_path(@direct_action.id), notice: 'Accion directa almacenada' }
            format.json { render action: 'show', status: :created, location: @direct_action }
          end
          
        end 
      end
    end
  end

  def save_direct_action
    @direct_action = DirectAction.find(params[:id])
    respond_to do |format|
      if @direct_action.update(direct_action_params)
          format.html { redirect_to direct_action_path(@direct_action.id), notice: '' }
          format.json { render action: 'show', status: :created, location: @direct_action }
      else
          format.html { render action: 'edit' }
          format.json { render json: @direct_action.errors, status: :unprocessable_entity }
      end
    end
    redirect_to direct_action_path(@direct_action.id)
  end

  # DELETE /direct_actions/1
  # DELETE /direct_actions/1.json
  def destroy
    @direct_action.destroy
    respond_to do |format|
      format.html { redirect_to direct_actions_url }
      format.json { head :no_content }
    end
  end

  def destroy_item
    @item = Item.find(params[:id_item])
    @direct_action = DirectAction.find(@item.direct_action_id)
    @item.destroy
    respond_to do |format|
      format.html { redirect_to edit_direct_action_path(@direct_action.id), notice: 'objeto eliminado' }
      format.json { head :no_content }
    end
  end

  def edit_item
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_direct_action
      @direct_action = DirectAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def direct_action_params
      params.require(:direct_action).permit(:police_name, :police_station, :police_ci, :police_grade, :station_zone, :police_phone, :station_acronym, :fact_date, :place, :nature, :fact_time, :cincunstancial_relation, :case_id)
    end

    def item_params
      params.require(:item).permit(:name, :description, :place, :direct_action_id)
    end
end
