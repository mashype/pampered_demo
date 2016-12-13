class VendorLicensesController < ApplicationController
  before_action :set_vendor_license, only: [:show, :edit, :update, :destroy]

  def index
    @vendor_licenses = VendorLicense.all
  end

  def show
  end

  def new
    @vendor_license = VendorLicense.new
  end

  def edit
  end

  def create
    @vendor_license = VendorLicense.new(vendor_license_params)

    respond_to do |format|
      if @vendor_license.save
        format.html { redirect_to @vendor_license, notice: 'Vendor license was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_license }
      else
        format.html { render :new }
        format.json { render json: @vendor_license.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vendor_license.update(vendor_license_params)
        format.html { redirect_to @vendor_license, notice: 'Vendor license was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_license }
      else
        format.html { render :edit }
        format.json { render json: @vendor_license.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vendor_license.destroy
    respond_to do |format|
      format.html { redirect_to vendor_licenses_url, notice: 'Vendor license was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_vendor_license
      @vendor_license = VendorLicense.find(params[:id])
    end

    def vendor_license_params
      params.require(:vendor_license).permit(:licenser, :name, :issue_date, :license_number, :vendor_id)
    end
end
