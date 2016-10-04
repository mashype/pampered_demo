class VendorServicesController < ApplicationController
  before_action :set_vendor_service, only: [:show, :edit, :update, :destroy]

  # GET /vendor_services
  # GET /vendor_services.json
  def index
    @vendor_services = VendorService.all
  end

  # GET /vendor_services/1
  # GET /vendor_services/1.json
  def show
  end

  # GET /vendor_services/new
  def new
    @vendor_service = VendorService.new
  end

  # GET /vendor_services/1/edit
  def edit
  end

  # POST /vendor_services
  # POST /vendor_services.json
  def create
    @vendor_service = VendorService.new(vendor_service_params)

    respond_to do |format|
      if @vendor_service.save
        format.html { redirect_to @vendor_service, notice: 'Vendor service was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_service }
      else
        format.html { render :new }
        format.json { render json: @vendor_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_services/1
  # PATCH/PUT /vendor_services/1.json
  def update
    respond_to do |format|
      if @vendor_service.update(vendor_service_params)
        format.html { redirect_to @vendor_service, notice: 'Vendor service was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_service }
      else
        format.html { render :edit }
        format.json { render json: @vendor_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_services/1
  # DELETE /vendor_services/1.json
  def destroy
    @vendor_service.destroy
    respond_to do |format|
      format.html { redirect_to vendor_services_url, notice: 'Vendor service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_service
      @vendor_service = VendorService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_service_params
      params.require(:vendor_service).permit(:vendor_id, :service_id, :notes)
    end
end
