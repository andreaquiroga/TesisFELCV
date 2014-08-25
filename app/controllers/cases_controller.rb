class CasesController < ApplicationController
  before_action :set_case, only: [:show, :edit, :update, :destroy]

  # GET /cases
  # GET /cases.json
  def index
    @cases = Case.all
  end

  # GET /cases/1
  # GET /cases/1.json
  def show
  end

  # GET /cases/new
  def new
    @case = Case.new
  end

  # GET /cases/1/edit
  def edit
    @case=Case.find(params[:id])
  end

  # POST /cases
  # POST /cases.json
  def create
    @case = Case.new(case_params)
    @case.user_id=current_user.id
    respond_to do |format|
      if @case.save
        format.html { redirect_to cases_path, notice: 'Caso creado!.' }
        
      else
        format.html { render action: 'new' }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
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
