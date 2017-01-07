class DurationsController < ApplicationController
  before_action :set_duration, only: [:show, :edit, :update, :destroy]
  before_action :verify_is_admin 

  def index
    @durations = Duration.all
  end

  def show
  end

  def new
    @duration = Duration.new
  end

  def edit
  end

  def create
    @duration = Duration.new(duration_params)

    respond_to do |format|
      if @duration.save
        format.html { redirect_to @duration, notice: 'Duration was successfully created.' }
        format.json { render :show, status: :created, location: @duration }
      else
        format.html { render :new }
        format.json { render json: @duration.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @duration.update(duration_params)
        format.html { redirect_to @duration, notice: 'Duration was successfully updated.' }
        format.json { render :show, status: :ok, location: @duration }
      else
        format.html { render :edit }
        format.json { render json: @duration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @duration.destroy
    respond_to do |format|
      format.html { redirect_to durations_url, notice: 'Duration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_duration
      @duration = Duration.find(params[:id])
    end

    def duration_params
      params.require(:duration).permit(:duration)
    end

    def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
    end
end
