require 'rubygems'
require 'RMagick'
include Magick

# A class to create an animated GIF that counts down from a given number of 
# seconds, minutes, hours and days to all zeros.
module Countdown
class CountdownImage
  attr_accessor :background_image, :background_color, :text_color, :pointsize, :font_weight, :width, :height
  attr_accessor :countdown_seconds, :days_position, :hours_position, :minutes_position, :seconds_position
  
  #Initialize the values with defaults then execute the block for user to define specific values in the constructor
  #TODO: move default values to separate property file? Or is that more a Java thing to do?
  #Also, executing the block may be needless complexity since the user can just set attributes as normal post-constructor.
  #No meaningful reason to prevent CountdownImage attributes from being read/writable and it makes setting draw attributes easier.
  #Still, it makes attribute assignment somewhat less messy-looking.
  def initialize(&block)
    @background_image = nil
    @background_color = 'gray'
    @text_color = 'blue'
    @pointsize = 40
    @font_weight = Magick::BoldWeight
    @width = 360
    @height = 80
    @countdown_seconds = 120
    @days_position = {x: 30, y: 20}
    @hours_position = {x: 120, y: 20}
    @minutes_position = {x: 210, y: 20}
    @seconds_position = {x: 300, y: 20}
    self.instance_eval(&block) unless block.nil?
  end
  
  def create_image(time)
    image_list = Magick::ImageList.new
    
    time_diff = TimeDifference.new(time, Time.new)
    o = self
    @countdown_seconds.downto(1).each do |value|
      image_list.new_image(@width, @height) {
          self.background_color = o.background_color                
          self.delay = 100
        }

      drawList = Magick::Draw.new { 
        self.gravity = Magick::SouthWestGravity
        self.pointsize = o.pointsize
        self.stroke = 'transparent'
        self.fill = o.text_color
        self.font_weight = o.font_weight
      }
      
      drawList.text(@days_position[:x], @days_position[:y], "#{time_diff.days}") 
      drawList.text(@hours_position[:x], @hours_position[:y], "#{time_diff.hours}") 
      drawList.text(@minutes_position[:x], @minutes_position[:y], "#{time_diff.minutes}") 
      drawList.text(@seconds_position[:x], @seconds_position[:y], "#{time_diff.seconds}") 
      drawList.draw(image_list.cur_image)
      break if time_diff.tick_down < 0
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
  
  attr_reader :days, :hours, :minutes, :seconds, :stop_at_zero, :time_difference
  
  def initialize(end_time, start_time, stop_at_zero = true)
    @time_difference = end_time - start_time
    @stop_at_zero = stop_at_zero
    recalculate
  end
  
  #decrement the timer by 1 and return the new number of seconds between the current time
  #and the end_time
  def tick_down
    @time_difference -= 1
    recalculate
    @time_difference
  end
    
  private
    def recalculate
      if time_difference <= 0 && @stop_at_zero
        @days = @hours = @minutes = @seconds = 0
      else
        @days = (@time_difference / @@SECONDS_IN_DAY).to_i
        @hours = ((@time_difference - (@days * @@SECONDS_IN_DAY)) / @@SECONDS_IN_HOUR).to_i
        @minutes = ((@time_difference - (@days * @@SECONDS_IN_DAY) - (@hours * @@SECONDS_IN_HOUR)) / @@SECONDS_IN_MINUTE).to_i
        @seconds = (@time_difference - (@days * @@SECONDS_IN_DAY) - (@hours * @@SECONDS_IN_HOUR) - (@minutes * @@SECONDS_IN_MINUTE)).to_i
      end
    end
end

end