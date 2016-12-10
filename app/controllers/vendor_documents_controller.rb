class VendorDocumentsController < ApplicationController
  before_action :set_vendor_document, only: [:show, :edit, :update, :destroy]

  # GET /vendor_documents
  # GET /vendor_documents.json
  def index
    @vendor_documents = VendorDocument.all
  end

  # GET /vendor_documents/1
  # GET /vendor_documents/1.json
  def show
  end

  # GET /vendor_documents/new
  def new
    @vendor_document = VendorDocument.new
  end

  # GET /vendor_documents/1/edit
  def edit
  end

  # POST /vendor_documents
  # POST /vendor_documents.json
  def create
    @vendor_document = VendorDocument.new(vendor_document_params)

    respond_to do |format|
      if @vendor_document.save
        format.html { redirect_to @vendor_document, notice: 'Vendor document was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_document }
      else
        format.html { render :new }
        format.json { render json: @vendor_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_documents/1
  # PATCH/PUT /vendor_documents/1.json
  def update
    respond_to do |format|
      if @vendor_document.update(vendor_document_params)
        format.html { redirect_to @vendor_document, notice: 'Vendor document was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_document }
      else
        format.html { render :edit }
        format.json { render json: @vendor_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_documents/1
  # DELETE /vendor_documents/1.json
  def destroy
    @vendor_document.destroy
    respond_to do |format|
      format.html { redirect_to vendor_documents_url, notice: 'Vendor document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_document
      @vendor_document = VendorDocument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_document_params
      params.require(:vendor_document).permit(:name, :vendor_id, :document)
    end
end
