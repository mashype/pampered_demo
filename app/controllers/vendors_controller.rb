class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  def index
    @vendors = Vendor.all

  end

  def show

    @appointments = Appointment.where(vendor_id: @vendor.id).order("created_at DESC") 

  end 

  def new
    @vendor = current_user.build_vendor
  end

  def edit
  end

  def create
    @vendor = current_user.build_vendor(vendor_params)

    respond_to do |format|
      if @vendor.save
        format.html { redirect_to @vendor, notice: 'Vendor was successfully created.' }
        format.json { render :show, status: :created, location: @vendor }
      else
        format.html { render :new }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vendor.update(vendor_params)
        format.html { redirect_to @vendor, notice: 'Vendor was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor }
      else
        format.html { render :edit }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vendor.destroy
    respond_to do |format|
      format.html { redirect_to vendors_url, notice: 'Vendor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    def vendor_params
      params.require(:vendor).permit(:user_id, :name, :avatar, :bio, 
        vendor_locations_attributes: [:id, :vendor_id, :location_id, :_destroy, 
          location_attributes: [:id, :add_1, :add_2, :city, :state, :zip, :latitude, :longitude, :_destroy]],
        vendor_services_attributes: [:id, :vendor_id, :service_id, :notes, :_destroy],
        vendor_licenses_attributes: [:id, :licenser, :name, :issue_date, :license_number, :_destroy])
    end

end
