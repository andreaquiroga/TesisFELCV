class InterviewsController < ApplicationController
  before_action :set_interview, only: [:show, :edit, :update, :destroy]

  # GET /interviews
  # GET /interviews.json
  def index
    @interviews = Interview.all
  end

  # GET /interviews/1
  # GET /interviews/1.json
  def show
  end

  # GET /interviews/new
  def new
    @interview = Interview.new
    @interview.case_id=params[:case_id]
    @case = Case.find(params[:case_id])
    @question = Question.new
    @interview.resume = "En la ciudad de Cochabamba a horas 18 del dia en dependencias de la Fuerza Especial de Lucha Contra la Violencia la suscrita "
    @interview.save
    #aca se genera el texto y condicionales
  end

  # GET /interviews/1/edit
  def edit
    @interview = Interview.find(params[:id])
    @case = Case.find(@interview.case_id)
    @question = Question.new
  end

  # POST /interviews
  # POST /interviews.json
  def create
    @interview = Interview.find(params[:interview][:id])
    @question = Question.new(question_params)
    @question.interview_id = @interview.id
    respond_to do |format|
      if @question.save
        format.html { redirect_to edit_interview_path(params[:interview][:id]), notice: 'Pregunta creada!' }
        format.json { render action: 'edit', status: :created, location: @interview }
      end
    end
  end

  def create_question
    
  end

  def edit_question
    @interview=Interview.find(@question.interview_id)
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to edit_interview_path(@interview), notice: 'Pregunta editada' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_question
    @question = Question.find(params[:id])
    @interview=Interview.find(@question.interview_id)
    @question.destroy
    redirect_to edit_interview_path(@interview)
  end

  # PATCH/PUT /interviews/1
  # PATCH/PUT /interviews/1.json
  def update
    @interview = Interview.find(params[:interview][:id])
    @question = Question.new(question_params)
    @question.interview_id = @interview.id
    respond_to do |format|
      if @question.save
        format.html { redirect_to edit_interview_path(params[:interview][:id]), notice: 'Pregunta creada!' }
        format.json { render action: 'edit', status: :created, location: @interview }
      end
    end
  end

  # DELETE /interviews/1
  # DELETE /interviews/1.json
  def destroy
    @interview.destroy
    respond_to do |format|
      format.html { redirect_to interviews_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interview_params
      params.require(:interview).permit(:resume)
    end

    def question_params
      params.require(:question).permit(:text, :answer)
    end
end
