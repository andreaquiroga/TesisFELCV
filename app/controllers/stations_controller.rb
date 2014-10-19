class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :destroy]

  # GET /stations
  # GET /stations.json
  def index
    @stations = Station.all
  end

  # GET /stations/1
  # GET /stations/1.json
  def show
    @station = Station.find(params[:id])
    @location=Location.find(@station.location_id)
    @hash = Gmaps4rails.build_markers(@location) do |l, marker|
      marker.lat l.latitude
      marker.lng l.longitude
      marker.infowindow l.address.to_s
    end
  end

  # GET /stations/new
  def new
    @station = Station.new
  end

  # GET /stations/1/edit
  def edit
    @station = Station.find(params[:id])
    @location=Location.find(@station.location_id)
    @station.location=@location
    @hash = Gmaps4rails.build_markers(@location) do |l, marker|
      marker.lat l.latitude
      marker.lng l.longitude
      marker.infowindow l.address.to_s
    end
  end

  # POST /stations
  # POST /stations.json
  def create
      @location=Location.new
      @location.latitude=params["latitude"]
      @location.longitude=params["longitude"]
      @location.address=params["address"]
      @location.place="estacion"
      @location.save
      @station = Station.new(station_params)
      @station.location_id = @location.id
      respond_to do |format|
        if @station.save
          format.html { redirect_to @station, notice: 'Unidad registrada.' }
          format.json { render action: 'show', status: :created, location: @station }
        else
          format.html { render action: 'new' }
          format.json { render json: @station.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /stations/1
  # PATCH/PUT /stations/1.json
  def update
    @station=Station.find(params[:station][:id])
    @location=Location.find(@station.location_id)
    @location.latitude=params[:station][:location][:latitude]
    @location.longitude=params[:station][:location][:longitude]
    @location.address=params[:station][:location][:address]
    @location.place="estacion"
    @location.save
    respond_to do |format|
      if @station.update(station_params)
        format.html { redirect_to @station, notice: 'Unidad modificada con exito.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stations/1
  # DELETE /stations/1.json
  def destroy
    @station.destroy
    respond_to do |format|
      format.html { redirect_to stations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station
      @station = Station.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def station_params
      params.require(:station).permit(:name, :phone)
    end

    def location_params
      params.require(:location).permit(:latitude, :longitude, :address)
    end
end
