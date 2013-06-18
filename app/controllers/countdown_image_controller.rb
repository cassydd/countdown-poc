include Countdown
class CountdownImageController < ApplicationController
  def index
  end
  
  def show
    time_param = params[:id]
    time = Time.parse(time_param)
    template_name = params[:image_template] || "default"
    countdown_image_descriptor = CountdownImageDescriptor.find_by name: template_name
    path = Rails.root.join('app', 'assets', 'images', countdown_image_descriptor.background_image) 
    image_data = IO.read(path, mode:"rb")
    countdown_image = Countdown::CountdownImage.new {
      self.countdown_seconds = 60
      self.font_weight = Magick::BoldWeight
      self.background_image = image_data
      self.text_color = countdown_image_descriptor.text_color
      self.pointsize = countdown_image_descriptor.pointsize
      self.width = countdown_image_descriptor.width
      self.height = countdown_image_descriptor.height
      self.days_position = {x: countdown_image_descriptor.days_position_x, y: countdown_image_descriptor.days_position_y}
      self.hours_position = {x: countdown_image_descriptor.hours_position_x, y: countdown_image_descriptor.hours_position_y}
      self.minutes_position = {x: countdown_image_descriptor.minutes_position_x, y: countdown_image_descriptor.minutes_position_y}
      self.seconds_position = {x: countdown_image_descriptor.seconds_position_x, y: countdown_image_descriptor.seconds_position_y}
    }
    send_data(countdown_image.create_image(time), disposition: 'inline', type: 'image/gif')
  end
end
