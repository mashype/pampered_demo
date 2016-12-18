class VendorTypesController < ApplicationController
  before_action :set_vendor_type, only: [:show, :edit, :update, :destroy]
  before_action :verify_is_admin

  def index
    @vendor_types = VendorType.all
  end

  def show
  end

  def new
    @vendor_type = VendorType.new
  end

  def edit
  end

  def create
    @vendor_type = VendorType.new(vendor_type_params)

    respond_to do |format|
      if @vendor_type.save
        format.html { redirect_to @vendor_type, notice: 'Vendor type was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_type }
      else
        format.html { render :new }
        format.json { render json: @vendor_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vendor_type.update(vendor_type_params)
        format.html { redirect_to @vendor_type, notice: 'Vendor type was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_type }
      else
        format.html { render :edit }
        format.json { render json: @vendor_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vendor_type.destroy
    respond_to do |format|
      format.html { redirect_to vendor_types_url, notice: 'Vendor type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_vendor_type
      @vendor_type = VendorType.find(params[:id])
    end

    def vendor_type_params
      params.require(:vendor_type).permit(:title)
    end

    def verify_is_admin
      (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
    end

end
