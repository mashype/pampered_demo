class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  def list
  end


  def index

    @vendors = Vendor.all

  end


  def membership

    @vendors = Vendor.all
    @vendor_list = @vendors.group_by { |t| t.vendor_type.title }

  end


  def massage

    if params[:search].present?
      location_ids = Location.near(params[:search], 100, order: '').pluck(:id)
    else
      location_ids = Location.near([session[:latitude], session[:longitude]], 1000, order: '').pluck(:id)      
    end

    @vendor_locations = VendorLocation.where(location_id: location_ids)
#    @vendors = Vendor.where(vendor_id: @vendor_locations.select(:vendor_id), vendor_type_id: 2)
    @vendors = Vendor.all



    @avg_reviews = []
    for singlevendor in @vendors
      @reviews = Review.where(vendor_id: singlevendor.id)

      if @reviews.blank?
        @avg_reviews << 0
      else
        @avg_reviews << @reviews.average(:rating).round(2)
      end
    end

  end

  def massagemembership

    @vendors = Vendor.where(vendor_type_id: 2)
  
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

    set_meta_tags   title: @vendor.name,
                    keywords: [@vendor.name, @vendor.vendor_type.title, @vendor.bio]

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
        format.html { redirect_to new_appointment_path, notice: 'Your Profile is up! Lets create a booking for people to find you.' }
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
        vendor_features_attributes: [:id, :vendor_id, :feature_id, :_destroy],
        vendor_licenses_attributes: [:id, :licenser, :name, :issue_date, :license_number, :_destroy])
    end

end
