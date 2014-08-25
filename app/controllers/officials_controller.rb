class OfficialsController < ApplicationController
  before_action :set_official, only: [:show, :edit, :update, :destroy]

  # GET /officials
  # GET /officials.json
  def index
    @officials = Official.all
  end

  # GET /officials/1
  # GET /officials/1.json
  def show
  end

  # GET /officials/new
  def new
    @official = Official.new
    @official.user_id=params[:user_id]
  end

  # GET /officials/1/edit
  def edit
  end

  # POST /officials
  # POST /officials.json
  def create
    @official = Official.new(official_params)
   
    respond_to do |format|
      if @official.save
        @user=User.new
        format.html { redirect_to root_path, notice: 'Oficial creado' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /officials/1
  # PATCH/PUT /officials/1.json
  def update
    respond_to do |format|
      if @official.update(official_params)
        format.html { redirect_to @official, notice: 'Official was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @official.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /officials/1
  # DELETE /officials/1.json
  def destroy
    @official.destroy
    respond_to do |format|
      format.html { redirect_to officials_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_official
      @official = Official.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def official_params

      params.require(:official).permit(:ci, :name, :paternal_last_name, :maternal_last_name, :grade, :address, :phone, :mobile, :birthdate, :admission_date, :last_work, :user_id)
    end
end
