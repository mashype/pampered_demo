class VendorLocationsController < ApplicationController
  before_action :set_vendor_location, only: [:show, :edit, :update, :destroy]

  # GET /vendor_locations
  # GET /vendor_locations.json
  def index
    @vendor_locations = VendorLocation.all
  end

  # GET /vendor_locations/1
  # GET /vendor_locations/1.json
  def show
  end

  # GET /vendor_locations/new
  def new
    @vendor_location = VendorLocation.new
  end

  # GET /vendor_locations/1/edit
  def edit
  end

  # POST /vendor_locations
  # POST /vendor_locations.json
  def create
    @vendor_location = VendorLocation.new(vendor_location_params)

    respond_to do |format|
      if @vendor_location.save
        format.html { redirect_to @vendor_location, notice: 'Vendor location was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_location }
      else
        format.html { render :new }
        format.json { render json: @vendor_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_locations/1
  # PATCH/PUT /vendor_locations/1.json
  def update
    respond_to do |format|
      if @vendor_location.update(vendor_location_params)
        format.html { redirect_to @vendor_location, notice: 'Vendor location was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_location }
      else
        format.html { render :edit }
        format.json { render json: @vendor_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_locations/1
  # DELETE /vendor_locations/1.json
  def destroy
    @vendor_location.destroy
    respond_to do |format|
      format.html { redirect_to vendor_locations_url, notice: 'Vendor location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_location
      @vendor_location = VendorLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_location_params
      params.require(:vendor_location).permit(:vendor_id, :location_id, :notes)
    end
end
