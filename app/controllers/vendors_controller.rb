class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  def list
  end


  def index
    @filterrific = initialize_filterrific(
      Vendor,
      params[:filterrific],
      :select_options => {
        sorted_by: Vendor.options_for_sorted_by,
        with_user_id: User.options_for_select,
        with_vendor_type_id: VendorType.options_for_select
      }
    ) or return
    @vendors = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end



  def show

    appointment_ids = Appointment.where(vendor_id: @vendor.id).pluck(:id)

    @reviews = Review.where(vendor_id: @vendor.id).order("created_at DESC")
    @bookings = Booking.where(appointment_id: appointment_ids).order("created_at DESC") 
    @appointments = Appointment.where(vendor_id: @vendor.id).order("created_at DESC") 

    

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end

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
      params.require(:vendor).permit(:user_id, :name, :vendor_type_id, :website, :sm_facebook, :sm_twitter, :sm_instagram, :sm_pinterest, :avatar, :bio, 
        vendor_locations_attributes: [:id, :vendor_id, :location_id, :_destroy, 
          location_attributes: [:id, :add_1, :add_2, :city, :state, :zip, :latitude, :longitude, :_destroy]],
        vendor_services_attributes: [:id, :vendor_id, :service_id, :notes, :_destroy],
        vendor_licenses_attributes: [:id, :licenser, :name, :issue_date, :license_number, :_destroy])
    end

end
