require 'test_helper'

class VendorFeaturesControllerTest < ActionController::TestCase
  setup do
    @vendor_feature = vendor_features(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vendor_features)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vendor_feature" do
    assert_difference('VendorFeature.count') do
      post :create, vendor_feature: { feature_id: @vendor_feature.feature_id, vendor_id: @vendor_feature.vendor_id }
    end

    assert_redirected_to vendor_feature_path(assigns(:vendor_feature))
  end

  test "should show vendor_feature" do
    get :show, id: @vendor_feature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vendor_feature
    assert_response :success
  end

  test "should update vendor_feature" do
    patch :update, id: @vendor_feature, vendor_feature: { feature_id: @vendor_feature.feature_id, vendor_id: @vendor_feature.vendor_id }
    assert_redirected_to vendor_feature_path(assigns(:vendor_feature))
  end

  test "should destroy vendor_feature" do
    assert_difference('VendorFeature.count', -1) do
      delete :destroy, id: @vendor_feature
    end

    assert_redirected_to vendor_features_path
  end
end
