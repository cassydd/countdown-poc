require 'rubygems'
require 'rufus/scheduler'
require 'icalendar'
require 'date'

class CountdownUsersController < ApplicationController
  before_action :set_countdown_user, only: [:show, :edit, :update, :destroy, :setup_scheduled_email, 
    :remove_scheduled_email, :schedule_email, :calendar_event, :setup_calendar_event]

  @@scheduler = Rufus::Scheduler.start_new

  def index
    user_token = cookies[:user_token]
    if user_token.nil?
      user_token = SecureRandom.uuid
      cookies[:user_token] = {
        :value => user_token, :expires => 1.year.from_now
      }
    end
    time_param = params[:time]
    
    #if this is a duplicate timer display an alert to determine whether to add it anyway or discard it
    unless time_param.nil? || params[:ignore_duplicate_check] == "true" || (existing_user_timer = CountdownUser.where("cookie_identifier = ? and time = ?", user_token, params[:time])).size == 0
      redirect_to url_for(action: "duplicate_found", time: params[:time])
      return
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
        format.js
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
  
  def setup_calendar_event
  end
  
  def remove_scheduled_email
    jobs = @@scheduler.find_by_tag(@countdown_user.user_scheduled_email.id)
    respond_to do |format|
      jobs.each {|job| logger.info "#{job.job_id}, #{job.params}" }
      if jobs.first.unschedule && @countdown_user.user_scheduled_email.destroy
        format.html { redirect_to countdown_users_path, notice: 'Notification has been cancelled.'}
      else
        format.html { redirect_to countdown_users_path, notice: 'Error cancelling the notification.'}
      end
    end
  end

  def schedule_email
    @user_scheduled_email = UserScheduledEmail.new(user_scheduled_email_params)
    @user_scheduled_email.countdown_user_id = @countdown_user.id
    @user_scheduled_email.scheduled_send_time = Time.parse(@countdown_user.time) - (params[:send_before].to_i * 60)
    respond_to do |format|
      if @user_scheduled_email.save
        @@scheduler.at @user_scheduled_email.scheduled_send_time, tags: @user_scheduled_email.id do
          UserMailer.notification_email(@countdown_user).deliver
        end
        format.html {redirect_to countdown_users_path, notice: 'Notification has been set up.'}
      else
        format.html { render action: 'setup_scheduled_email'}
      end
    end
  end

  def calendar_event
    respond_to do |format|
      format.html
      format.ics do
        calendar = Icalendar::Calendar.new
        event_time = Time.parse(@countdown_user.time).strftime("%Y%m%dT%H%M%S")
        send_before = params[:send_before].to_i
        timer_title = @countdown_user.timer_title || "Untitled timer"
        calendar.event do
          dtstart   event_time
          dtend     event_time
          summary   timer_title
          klass     "PRIVATE"
          alarm do
            summary   "#{timer_title} expiry"
            trigger   "-PT#{send_before}M"
          end
        end
        calendar.publish
        render text: calendar.to_ical
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

  def duplicate_found
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
