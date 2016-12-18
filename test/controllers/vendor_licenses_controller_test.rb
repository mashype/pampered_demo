require 'test_helper'

class VendorLicensesControllerTest < ActionController::TestCase
  setup do
    @vendor_license = vendor_licenses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_licenses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendor_license" do
    assert_difference('VendorLicense.count') do
      post :create, vendor_license: { issue_date: @vendor_license.issue_date, license_number: @vendor_license.license_number, licenser: @vendor_license.licenser, name: @vendor_license.name, vendor_id: @vendor_license.vendor_id }
    end

    assert_redirected_to vendor_license_path(assigns(:vendor_license))
  end

  test "should show vendor_license" do
    get :show, id: @vendor_license
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vendor_license
    assert_response :success
  end

  test "should update vendor_license" do
    patch :update, id: @vendor_license, vendor_license: { issue_date: @vendor_license.issue_date, license_number: @vendor_license.license_number, licenser: @vendor_license.licenser, name: @vendor_license.name, vendor_id: @vendor_license.vendor_id }
    assert_redirected_to vendor_license_path(assigns(:vendor_license))
  end

  test "should destroy vendor_license" do
    assert_difference('VendorLicense.count', -1) do
      delete :destroy, id: @vendor_license
    end

    assert_redirected_to vendor_licenses_path
  end
end
