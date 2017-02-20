require 'test_helper'

class CouponsControllerTest < ActionController::TestCase
  setup do
    @coupon = coupons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon" do
    assert_difference('Coupon.count') do
      post :create, coupon: { code_string: @coupon.code_string, disc_cost: @coupon.disc_cost, disc_pct: @coupon.disc_pct, exp_date: @coupon.exp_date, max_price: @coupon.max_price, max_value: @coupon.max_value, min_price: @coupon.min_price, min_value: @coupon.min_value }
    end

    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should show coupon" do
    get :show, id: @coupon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon
    assert_response :success
  end

  test "should update coupon" do
    patch :update, id: @coupon, coupon: { code_string: @coupon.code_string, disc_cost: @coupon.disc_cost, disc_pct: @coupon.disc_pct, exp_date: @coupon.exp_date, max_price: @coupon.max_price, max_value: @coupon.max_value, min_price: @coupon.min_price, min_value: @coupon.min_value }
    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should destroy coupon" do
    assert_difference('Coupon.count', -1) do
      delete :destroy, id: @coupon
    end

    assert_redirected_to coupons_path
  end
end
