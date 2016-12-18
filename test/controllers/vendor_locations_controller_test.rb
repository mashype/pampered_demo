require 'test_helper'

class VendorLocationsControllerTest < ActionController::TestCase
  setup do
    @vendor_location = vendor_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendor_location" do
    assert_difference('VendorLocation.count') do
      post :create, vendor_location: { location_id: @vendor_location.location_id, notes: @vendor_location.notes, vendor_id: @vendor_location.vendor_id }
    end

    assert_redirected_to vendor_location_path(assigns(:vendor_location))
  end

  test "should show vendor_location" do
    get :show, id: @vendor_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vendor_location
    assert_response :success
  end

  test "should update vendor_location" do
    patch :update, id: @vendor_location, vendor_location: { location_id: @vendor_location.location_id, notes: @vendor_location.notes, vendor_id: @vendor_location.vendor_id }
    assert_redirected_to vendor_location_path(assigns(:vendor_location))
  end

  test "should destroy vendor_location" do
    assert_difference('VendorLocation.count', -1) do
      delete :destroy, id: @vendor_location
    end

    assert_redirected_to vendor_locations_path
  end
end
