json.array!(@countdown_image_descriptors) do |countdown_image_descriptor|
  json.extract! countdown_image_descriptor, :background_image, :background_color, :text_color, :pointsize, :font_weight, :width, :height, :days_position_x, :days_position_y, :hours_position_x, :hours_position_y, :minutes_position_x, :minutes_position_y, :seconds_position_x, :seconds_position_y
  json.url countdown_image_descriptor_url(countdown_image_descriptor, format: :json)
end