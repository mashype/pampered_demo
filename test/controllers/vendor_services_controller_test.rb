require 'test_helper'

class VendorServicesControllerTest < ActionController::TestCase
  setup do
    @vendor_service = vendor_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendor_service" do
    assert_difference('VendorService.count') do
      post :create, vendor_service: { notes: @vendor_service.notes, service_id: @vendor_service.service_id, vendor_id: @vendor_service.vendor_id }
    end

    assert_redirected_to vendor_service_path(assigns(:vendor_service))
  end

  test "should show vendor_service" do
    get :show, id: @vendor_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vendor_service
    assert_response :success
  end

  test "should update vendor_service" do
    patch :update, id: @vendor_service, vendor_service: { notes: @vendor_service.notes, service_id: @vendor_service.service_id, vendor_id: @vendor_service.vendor_id }
    assert_redirected_to vendor_service_path(assigns(:vendor_service))
  end

  test "should destroy vendor_service" do
    assert_difference('VendorService.count', -1) do
      delete :destroy, id: @vendor_service
    end

    assert_redirected_to vendor_services_path
  end
end
