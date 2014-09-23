class ConclusionsController < ApplicationController
  before_action :set_conclusion, only: [:show, :edit, :destroy]

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

  # POST /conclusions
  # POST /conclusions.json
  def create
    @conclusion = Conclusion.new(conclusion_params)

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
