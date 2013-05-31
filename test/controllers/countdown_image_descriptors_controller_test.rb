require 'test_helper'

class CountdownImageDescriptorsControllerTest < ActionController::TestCase
  setup do
    @countdown_image_descriptor = countdown_image_descriptors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:countdown_image_descriptors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create countdown_image_descriptor" do
    assert_difference('CountdownImageDescriptor.count') do
      post :create, countdown_image_descriptor: { background_color: @countdown_image_descriptor.background_color, background_image: @countdown_image_descriptor.background_image, days_position_x: @countdown_image_descriptor.days_position_x, days_position_y: @countdown_image_descriptor.days_position_y, font_weight: @countdown_image_descriptor.font_weight, height: @countdown_image_descriptor.height, hours_position_x: @countdown_image_descriptor.hours_position_x, hours_position_y: @countdown_image_descriptor.hours_position_y, minutes_position_x: @countdown_image_descriptor.minutes_position_x, minutes_position_y: @countdown_image_descriptor.minutes_position_y, pointsize: @countdown_image_descriptor.pointsize, seconds_position_x: @countdown_image_descriptor.seconds_position_x, seconds_position_y: @countdown_image_descriptor.seconds_position_y, text_color: @countdown_image_descriptor.text_color, width: @countdown_image_descriptor.width }
    end

    assert_redirected_to countdown_image_descriptor_path(assigns(:countdown_image_descriptor))
  end

  test "should show countdown_image_descriptor" do
    get :show, id: @countdown_image_descriptor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @countdown_image_descriptor
    assert_response :success
  end

  test "should update countdown_image_descriptor" do
    patch :update, id: @countdown_image_descriptor, countdown_image_descriptor: { background_color: @countdown_image_descriptor.background_color, background_image: @countdown_image_descriptor.background_image, days_position_x: @countdown_image_descriptor.days_position_x, days_position_y: @countdown_image_descriptor.days_position_y, font_weight: @countdown_image_descriptor.font_weight, height: @countdown_image_descriptor.height, hours_position_x: @countdown_image_descriptor.hours_position_x, hours_position_y: @countdown_image_descriptor.hours_position_y, minutes_position_x: @countdown_image_descriptor.minutes_position_x, minutes_position_y: @countdown_image_descriptor.minutes_position_y, pointsize: @countdown_image_descriptor.pointsize, seconds_position_x: @countdown_image_descriptor.seconds_position_x, seconds_position_y: @countdown_image_descriptor.seconds_position_y, text_color: @countdown_image_descriptor.text_color, width: @countdown_image_descriptor.width }
    assert_redirected_to countdown_image_descriptor_path(assigns(:countdown_image_descriptor))
  end

  test "should destroy countdown_image_descriptor" do
    assert_difference('CountdownImageDescriptor.count', -1) do
      delete :destroy, id: @countdown_image_descriptor
    end

    assert_redirected_to countdown_image_descriptors_path
  end
end
