class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update, :destroy]

  #simple search
  def simple_search
    @cases = Case.search(params[:code])
    
  end

  def advanced_search
    @cases1= Case.advanced_search_nature(params[:nature]) 
    @cases2= Case.advanced_search_researcher(params[:researcher])
    @cases3= Case.advanced_search_person(params[:name])
    @cases=(@cases1&@cases2&@cases3).uniq
  end

  # GET /cases
  # GET /cases.json
  def index
    @cases = Case.all
  end

  # GET /cases/1
  # GET /cases/1.json
  def show
    @case=Case.find(params[:id])
    #@complaint=Complaint.where(:case_id=>params[:id]).first
    @complaint=Complaint.new
    @person=Person.new
    @link=Link.new
    
  end

  # GET /cases/new
  def new
    @case = Case.new
    @case.user_id = current_user.id
    @case.init_date = Date.today
    @case.code="felcv"
    @case.save
    @case_complete = Case.find(@case.id)
    @case_complete.code = "felcv-"+@case.id.to_s+"-cbba"
    if @case_complete.save
      flash[:notice] = "Caso creado."
      redirect_to case_path(@case.id)
    else
      flash[:notice] = "Error al crear el caso, contacte al administrador."
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
