class VendorLocationsController < ApplicationController
  before_action :set_vendor_location, only: [:show, :edit, :update, :destroy]

  def index
    @vendor_locations = VendorLocation.all
  end

  def show
  end

  def new
    @vendor_location = VendorLocation.new
  end

  def edit
  end

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
