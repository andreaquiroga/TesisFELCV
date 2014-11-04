class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  #simple search
  def simple_search
    @cases = Case.search(params[:code])
    if params[:mine]=="true"
      @mine=true
    else
      @mine=false
    end
  end

  def advanced_search
    @cases1= Case.advanced_search_nature(params[:nature]) 
    @cases2= Case.advanced_search_researcher(params[:researcher])
    @cases3= Case.advanced_search_person(params[:name])
    @cases=(@cases1&@cases2&@cases3).uniq
    if params[:mine]=="true"
      @mine=true
    else
      @mine=false
    end
  end

  # GET /cases
  # GET /cases.json
  def index
    @mine = false
    @cases = Case.all
  end

  def index_mine
    @mine = true
    @cases = Case.where(:user_id=>current_user.id)
  end

  def index_mine_station
    @mine = false
    @cases = Case.joins(:user).where('users.station_id = ?', current_user.station_id)
  end

  def reassign_case
    @case = Case.find(params[:id])
    @users = User.where('status = ? and role = ? and station_id= ?', "Activo", "investigador", current_user.station_id)
  end

  def assign
    @case=Case.find(params[:id])
    @case.user_id = params[:users]
    if @case.save
      flash[:notice] = "Caso reasignado correctamente!"
      redirect_to cases_path
    else
      flash[:error] = "No se puedo reasignar el caso"
      redirect_to :back
    end
  end

  # GET /cases/1
  # GET /cases/1.json
  def show
    @case=Case.find(params[:id])
    @complaint=Complaint.new
    @person=Person.new
    @link=Link.new
  end

  # GET /cases/new
  def new
    @case = Case.new
    @case.init_date = Date.today
    @case.code="felcv"
    
    @user=User.where('status = ? and role = ? and station_id= ?', "Activo", "investigador", current_user.station_id).order("turn ASC").first
    if @user != nil
      @case.user_id=@user.id
      @case.save
      @user.turn = User.maximum("turn") + 1
      @user.save(:validate => false)    
      @case_complete = Case.find(@case.id)
      @case_complete.code = "felcv-"+@case.id.to_s+"-cbba"
      if @case_complete.save
        UserMailer.new_case_mailer(@case, @user).deliver
        flash[:notice] = "Caso creado."
        redirect_to case_path(@case.id)
      else
        flash[:notice] = "Error al crear el caso, contacte al administrador."
        redirect_to root_path
      end
    else
      flash[:warning] = "No existen investigadores disponibles para la asignacion de casos"
      redirect_to root_path
    end
  end

  # GET /cases/1/edit
  def edit
    @case=Case.find(params[:id])
  end

  # POST /cases
  # POST /cases.json
  def create
  end

  # PATCH/PUT /cases/1
  # PATCH/PUT /cases/1.json
  def update
    @case=Case.find(params[:id])
    @case.end_date=Date.today.to_s
    respond_to do |format|
      if @case.save
        format.html { redirect_to cases_path, notice: 'Caso Cerrado!.' }
        format.json { head :no_content }
      else
        format.html { redirect_to cases_path, notice: 'Caso no pudo cerrarse! Intente mas tarde.' }
      end
    end
  end

  # DELETE /cases/1
  # DELETE /cases/1.json
  def destroy
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_params
      params.require(:case).permit(:code, :init_date, :end_date)
    end
end
