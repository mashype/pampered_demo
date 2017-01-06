class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]


  def aptfilter

    if params[:zip_search].present?
      location_ids = Location.near(params[:zip_search], 50, order: '').pluck(:id)

    else
      location_ids = Location.near([session[:latitude], session[:longitude]], 50, order: '').pluck(:id)
    end 

    @filterrific = initialize_filterrific(
      Appointment.includes(:vendor),
      params[:filterrific],
      select_options:{ sorted_by: Appointment.options_for_sorted_by, with_service_id: Service.options_for_select },
      ) or return
    
    @vendor_locations = VendorLocation.where(location_id: location_ids)
    @appointments = @filterrific.find.includes(:vendor).where(vendor_id: @vendor_locations.select(:vendor_id)).page(params[:page])

    @hash = Gmaps4rails.build_markers(@vendor_locations) do |vendor_location, marker|
      marker.lat vendor_location.location.latitude
      marker.lng vendor_location.location.longitude
      marker.infowindow vendor_location.vendor.name
    end

    respond_to do |format|
      format.html
      format.js
    end

  end


  def index 

    if params[:search].present?
      location_ids = Location.near(params[:search], 50, order: '').pluck(:id)
    else
      location_ids = Location.near([session[:latitude], session[:longitude]], 50, order: '').pluck(:id)      
    end

    @vendor_locations = VendorLocation.where(location_id: location_ids)
    @appointments = Appointment.includes(:vendor).order('updated_at DESC').where(vendor_id: @vendor_locations.select(:vendor_id), :active => true)


    @avg_reviews = []
    for singleappointment in @appointments
      @reviews = Review.where(vendor_id: singleappointment.vendor.id)

      if @reviews.blank?
        @avg_reviews << 0
      else
        @avg_reviews << @reviews.average(:rating).round(2)
      end
    end

    @hash = Gmaps4rails.build_markers(@vendor_locations) do |vendor_location, marker|
      marker.lat vendor_location.location.latitude
      marker.lng vendor_location.location.longitude
      marker.infowindow vendor_location.vendor.name
    end
  end

  def show
    set_meta_tags   title: @appointment.title,
                    keywords: ["Pampered", "GetYourPamp", "pamperedup", @appointment.vendor.name, @appointment.vendor.vendor_type.title, @appointment.title, @appointment.description]
  end

  def new
    @appointment = Appointment.new
    @services = Service.where(vendor_type_id: current_user.vendor.vendor_type_id)
  end

  def edit
    @services = Service.where(vendor_type_id: current_user.vendor.vendor_type_id)
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.vendor_id = current_user.vendor.id

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:title, :description, :active, :vendor_id, :service_id, :amount_id)
    end
end
