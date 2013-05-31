include Countdown
class CountdownImageController < ApplicationController
  def index
  end
  
  def show
    time_param = params[:id]
    time = Time.parse(time_param)
    countdown_image = Countdown::CountdownImage.new {
      self.background_color = 'red'
    }
    send_data(countdown_image.create_image(time), :disposition=>'inline', :type=>'image/gif')
  end
end
