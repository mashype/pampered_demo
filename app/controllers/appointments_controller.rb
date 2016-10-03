class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if params[:service].blank?
      @appointments = Appointment.all.order("created_at DESC")
    else
      @service_id = Service.find_by(title: params[:service]).id
      @appointments = Appointment.where(service_id: @service_id).order("created_at DESC")
    end

    if params[:search].present?
      location_ids = Location.near(params[:search], 50, order: '').pluck(:id)
      @vendor_locations = VendorLocation.includes(:location).where(location_id: location_ids)
    else
      location_ids = Location.near([session[:latitude], session[:longitude]], 50, order: '').pluck(:id)
      @vendor_locations = VendorLocation.includes(:location).where(location_id: location_ids)
    end

    @hash = Gmaps4rails.build_markers(@vendor_locations) do |vendor_location, marker|
      marker.lat vendor_location.location.latitude
      marker.lng vendor_location.location.longitude
    end
  end

  def show
  end

  def new
    @appointment = Appointment.new
  end

  def edit
  end

  def create
    @appointment = Appointment.new(appointment_params)

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
      params.require(:appointment).permit(:title, :description, :user_id, :service_id, :amount_id)
    end
end
