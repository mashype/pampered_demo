class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_appointment
  before_action :authenticate_user!

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def edit
  end

  def create
    @booking = Booking.new booking_params.merge(email: stripe_params["stripeEmail"], card_token: stripe_params["stripeToken"])
    @booking.user_id = current_user.id
    @booking.appointment_id = @appointment.id
    raise "Please, check registration errors" unless @booking.valid?
    @booking.process_payment stripe_params['stripeToken']
    @booking.save
    redirect_to appointment_booking_path(@appointment.id, @booking.id), :notice => 'Confirmation was successfully updated.'

  rescue Exception => e
    flash[:error] = e.message
    render :new
  end


  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end 

  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def stripe_params
      params.permit :stripeEmail, :stripeToken, :appointment_id, :utf8, :authenticity_token, :booking, :stripeTokenType
    end

    def set_appointment
      @appointment = Appointment.find(params[:appointment_id])
    end

    def booking_params
      params.require(:booking).permit(:user_id, :appointment_id, :conf_temp, :email, :card_token)
    end

end
