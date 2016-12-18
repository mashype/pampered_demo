require 'test_helper'

class VendorDocumentsControllerTest < ActionController::TestCase
  setup do
    @vendor_document = vendor_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendor_document" do
    assert_difference('VendorDocument.count') do
      post :create, vendor_document: { name: @vendor_document.name, vendor_id: @vendor_document.vendor_id }
    end

    assert_redirected_to vendor_document_path(assigns(:vendor_document))
  end

  test "should show vendor_document" do
    get :show, id: @vendor_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vendor_document
    assert_response :success
  end

  test "should update vendor_document" do
    patch :update, id: @vendor_document, vendor_document: { name: @vendor_document.name, vendor_id: @vendor_document.vendor_id }
    assert_redirected_to vendor_document_path(assigns(:vendor_document))
  end

  test "should destroy vendor_document" do
    assert_difference('VendorDocument.count', -1) do
      delete :destroy, id: @vendor_document
    end

    assert_redirected_to vendor_documents_path
  end
end
