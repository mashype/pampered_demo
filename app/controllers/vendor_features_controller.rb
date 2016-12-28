class VendorFeaturesController < ApplicationController
  before_action :set_vendor_feature, only: [:show, :edit, :update, :destroy]

  # GET /vendor_features
  # GET /vendor_features.json
  def index
    @vendor_features = VendorFeature.all
  end

  # GET /vendor_features/1
  # GET /vendor_features/1.json
  def show
  end

  # GET /vendor_features/new
  def new
    @vendor_feature = VendorFeature.new
  end

  # GET /vendor_features/1/edit
  def edit
  end

  # POST /vendor_features
  # POST /vendor_features.json
  def create
    @vendor_feature = VendorFeature.new(vendor_feature_params)

    respond_to do |format|
      if @vendor_feature.save
        format.html { redirect_to @vendor_feature, notice: 'Vendor feature was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_feature }
      else
        format.html { render :new }
        format.json { render json: @vendor_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_features/1
  # PATCH/PUT /vendor_features/1.json
  def update
    respond_to do |format|
      if @vendor_feature.update(vendor_feature_params)
        format.html { redirect_to @vendor_feature, notice: 'Vendor feature was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_feature }
      else
        format.html { render :edit }
        format.json { render json: @vendor_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_features/1
  # DELETE /vendor_features/1.json
  def destroy
    @vendor_feature.destroy
    respond_to do |format|
      format.html { redirect_to vendor_features_url, notice: 'Vendor feature was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_feature
      @vendor_feature = VendorFeature.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_feature_params
      params.require(:vendor_feature).permit(:vendor_id, :feature_id)
    end
end
