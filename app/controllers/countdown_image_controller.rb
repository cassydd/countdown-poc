include Countdown
class CountdownImageController < ApplicationController
  def index
  end
  
  def show
    time_param = params[:id]
    time = Time.parse(time_param)
    #Clearly I'm only using the rails.png image as a placeholder.
    path = Rails.root.join('app', 'assets', 'images', 'rails.png')
    image_data = IO.read(path, mode:"rb")
    countdown_image = Countdown::CountdownImage.new {
      self.background_image = image_data
      self.text_color = "black"
      self.countdown_seconds = 30
    }
    send_data(countdown_image.create_image(time), disposition: 'inline', type: 'image/gif')
  end
end
