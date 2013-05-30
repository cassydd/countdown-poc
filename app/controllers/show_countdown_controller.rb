class ShowCountdownController < ApplicationController
  def index
    user_token = cookies[:user_token]
    if user_token.nil?
      user_token = SecureRandom.uuid
      cookies[:user_token] = {
        :value => user_token, :expires => 1.year.from_now
      }
    end
    @user_timers = CountdownUser.where("cookie_identifier = ?", user_token)
    unless params[:time].nil?
      @user_timer = CountdownUser.new
      @user_timer.cookie_identifier = user_token
      @user_timer.time = params[:time]
      @user_timer.save
    end
  end
  
end
