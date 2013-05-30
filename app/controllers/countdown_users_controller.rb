require 'rubygems'
require 'rufus/scheduler'

class CountdownUsersController < ApplicationController
  before_action :set_countdown_user, only: [:show, :edit, :update, :destroy, :setup_scheduled_email, :schedule_email]

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

  # PATCH/PUT /countdown_users/1
  # PATCH/PUT /countdown_users/1.json
  def update
    respond_to do |format|
      if @countdown_user.update(countdown_user_params)
        format.html { redirect_to countdown_users_path, notice: 'Countdown was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to countdown_users_path, notice: 'Failed to update countdown.' }
        format.json { render json: @countdown_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def setup_scheduled_email
    @user_scheduled_email = UserScheduledEmail.new
  end

  def schedule_email
    @user_scheduled_email = UserScheduledEmail.new(user_scheduled_email_params)
    @user_scheduled_email.countdown_user_id = @countdown_user.id
    @user_scheduled_email.scheduled_send_time = Time.parse(@countdown_user.time) - (params[:send_before].to_i * 60)
    respond_to do |format|
      if @user_scheduled_email.save
        scheduler = Rufus::Scheduler.start_new
        scheduler.at @user_scheduled_email.scheduled_send_time do
          UserMailer.notification_email(@countdown_user).deliver
        end
        format.html {redirect_to countdown_users_path, notice: 'Notification has been set up.'}
      else
        format.html { render action: 'setup_scheduled_email'}
      end
    end
  end

  def destroy
    @countdown_user.destroy
    respond_to do |format|
      format.html { redirect_to countdown_users_path, notice: 'The countdown timer has been removed.' }
      format.json { head :no_content }
    end
  end


  def show
  end

  private
  def set_countdown_user
    @countdown_user = CountdownUser.find(params[:id])
  end

  def countdown_user_params
    params.require(:countdown_user).permit(:timer_title, :email)
  end

  def user_scheduled_email_params
    params.require(:user_scheduled_email).permit(:email_address)
  end
end
