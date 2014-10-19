class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @links = Link.includes(:person).where(:case_id=>params[:id])
    @case = Case.find(params[:id])
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @link=Link.find(params[:id])
    @person = Person.find(@link.person_id)
    @case = Case.find(@link.case_id)
    @location_home=Location.find(@person.location_home_id)
    @location_work=Location.find(@person.location_work_id)
    @hash1 = Gmaps4rails.build_markers(@location_home) do |l, marker|
      marker.lat l.latitude
      marker.lng l.longitude
      marker.infowindow l.address.to_s
    end
    @hash2 = Gmaps4rails.build_markers(@location_work) do |l, marker|
      marker.lat l.latitude
      marker.lng l.longitude
      marker.infowindow l.address.to_s
    end
  end

  # GET /people/new
  def new
    @person = Person.new
    @link=Link.new
    @case= Case.find(params[:case_id])
    @link.case_id=params[:case_id]
    @location_home=Location.new
    @location_home.place="casa"
    @person.location_home_id=@location_home.id
  end

  def continue_new
    @link = Link.find(params[:link_id])
    @person = Person.find(@link.person_id)
    @case = Case.find(@link.case_id)
    @location_work=Location.new
    @location_work.place="trabajo"

    @person.location_work_id=@location_work.id
  end

  # GET /people/1/edit
  def edit
    @link = Link.find(params[:id])
    @case = Case.find(@link.case_id)
    @person = Person.find(@link.person_id)
    @location_work = Location.find(@person.location_work_id)
    @location_home = Location.find(@person.location_home_id)
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    @link=Link.new
    @location=Location.new
    @link=link_params(@link)
    @location_home=location_params(@location)
    @case= Case.find(@link.case_id)
    if @location_home.save
      @person.location_home_id=@location_home.id
      respond_to do |format|
        if @person.save
          @link.person_id=@person.id
          @link.case_id=params[:person][:link][:case_id]
          if @link.save
            #format.html { redirect_to continue_new_person_path(@link.id), notice: @person.id }
            format.html { redirect_to continue_new_path(@link.id), warning: "continue con el registro" }
          end
        else
          format.html { render action: 'new' }
          format.json { render json: @person.errors, status: :unprocessable_entity }
        end
      end
    end
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
            format.html { redirect_to person_path(@person.id), notice: "Persona creada exitosamente" }
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

    def person_work_params(person)
      person.ocupation=params[:person][:ocupation]
      person.work=params[:person][:work]
      person.work_phone=params[:person][:work_phone]
      return person
    end

    def location_params(location)
      location.latitude=params[:person][:location][:latitude]
      location.longitude=params[:person][:location][:longitude]
      location.address=params[:person][:location][:address]
      location.place=params[:person][:location][:place]
      return location
    end
end
