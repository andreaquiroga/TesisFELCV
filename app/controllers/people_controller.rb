class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
    @link=Link.new
    @case= Case.find(params[:case_id])
    @link.case_id=params[:case_id]
   # @location_work=Location.new
   # @location_work.place="trabajo"
   # @location_home=Location.new
   # @location_home.place="casa"
   # @person.location_home_id=@location_home.id
   # @person.location_work_id=@location_work.id
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    @link=Link.new
   # @location=Location.new
    @link=link_params(@link)
   # @location_home=location_params(@location)
   # if @location_home.save
   #   @person.location_home_id=@location_home.id
      respond_to do |format|
        if @person.save
          @link.person_id=@person.id
          @link.case_id=params[:person][:link][:case_id]
          if @link.save
            #format.html { redirect_to continue_new_person_path(@link.id), notice: @person.id }
            format.html { redirect_to case_path(@link.case_id), notice: "persona creada" }
          end
        else
          format.html { render action: 'new' }
          format.json { render json: @person.errors, status: :unprocessable_entity }
        end
      end
  #  else
  #    format.html { render action: 'new' }
  #    format.json { render json: @person.errors, status: :unprocessable_entity }
  #  end
  end

  def continue_new
    @person=Person.find(params[:person_id])
    @location_work=Location.new
    @location_work.place="trabajo"
    @person.location_work_id=@location_work.id  
  end

  def continue_create
    @person = Person.find(params[:person][:id])
    @person=person_work_params(@person)
    @location=Location.new
    @location_work=location_params(@location)
    if @location_work.save
      @person.location_work_id=@location_work.id
    respond_to do |format|
      if @person.save
          format.html { redirect_to person_path(@person.id), notice: "Persona creada con exito" }
          format.json { render action: 'show/'+@person.id.to_s, status: :created, location: @person }
      else
        format.html { render action: 'continue_new' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  else
    format.html { render action: 'new' }
    format.json { render json: @person.errors, status: :unprocessable_entity }
  end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      #params.require(:person).permit(:ci, :name, :paternal_last_name, :maternal_last_name, :civil_status, :nationality, :natural_of, :work, :work_address, :work_phone, :ocupation, :gender, :phone, :mobile, :birthdate)
      params.require(:person).permit(:ci, :name, :paternal_last_name, :maternal_last_name, :civil_status, :nationality, :natural_of, :gender, :phone, :mobile, :birthdate)
    end

    def link_params(link)
      link.role=params[:person][:link][:role]
      link.case_id=params[:person][:link][:case_id]
      return link
    end
end
