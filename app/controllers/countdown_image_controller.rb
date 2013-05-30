include Countdown
class CountdownImageController < ApplicationController
  def index
  end
  
  def show
    time_param = params[:id]
    time = Time.parse(time_param)
    send_data(Countdown::CountdownImage.create_image(time, {}), :disposition=>'inline', :type=>'image/gif')
  end
end
