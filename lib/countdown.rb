require 'rubygems'
require 'RMagick'
include Magick

# A class to create an animated GIF that counts down from a given number of 
# seconds, minutes, hours and days to all zeros.
module Countdown
class CountdownImage
  @@default_values = {
    background_color: 'gray',
    text_color: 'blue',
    pointsize: 15,
    font_weight: Magick::BoldWeight,
    width: 240,
    height: 40,
    countdown_seconds: 120,
    days_position: {x: 10, y: 10},
    hours_position: {x: 50, y: 10},
    minutes_position: {x: 110, y: 10},
    seconds_position: {x: 160, y: 10}
  }
  
  def self.create_image(time, props)
    image_list = Magick::ImageList.new
    
    countdown_seconds = props[:countdown_seconds] || @@default_values[:countdown_seconds]
    time_diff = TimeDifference.new(time, Time.new)
    countdown_seconds.downto(1).each do |value|
      image_list.new_image(props[:width] || @@default_values[:width], 
        props[:height] || @@default_values[:height]) {
          self.background_color = props[:background_color] || @@default_values[:background_color]                
          self.delay = 100
        }

      text = Magick::Draw.new
      text.annotate(image_list.cur_image, 0, 0, 0, 10, 
          "#{time_diff.days} days #{time_diff.hours} hours #{time_diff.minutes} min #{time_diff.seconds} sec") { 
        self.gravity = Magick::SouthGravity
        self.pointsize = props[:pointsize] || @@default_values[:pointsize]
        self.stroke = 'transparent'
        self.fill = props[:text_color] || @@default_values[:text_color]
        self.font_weight = props[:font_weight] || @@default_values[:font_weight]
      }
      time_diff.tick_down
    end

    image_blob = image_list.to_blob {
      self.format = 'gif'
    }
    image_blob
  end
end

class TimeDifference
  
  @@SECONDS_IN_DAY = (24 * 60 * 60)
  @@SECONDS_IN_HOUR = (60 * 60)
  @@SECONDS_IN_MINUTE = 60
  
  def initialize(time1, time2)
    @time_difference = time1 - time2
  end
  
  def days
    (@time_difference / @@SECONDS_IN_DAY).to_i
  end
  
  def hours
    ((@time_difference - (self.days * @@SECONDS_IN_DAY)) / @@SECONDS_IN_HOUR).to_i
  end
  
  def minutes
    ((@time_difference - (self.days * @@SECONDS_IN_DAY) - (self.hours * @@SECONDS_IN_HOUR))/ @@SECONDS_IN_MINUTE).to_i 
  end
  
  def seconds
    (@time_difference % @@SECONDS_IN_MINUTE).to_i
  end
  
  def tick_down
    @time_difference -= 1
  end
end

end