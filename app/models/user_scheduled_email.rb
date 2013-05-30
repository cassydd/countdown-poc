class UserScheduledEmail < ActiveRecord::Base
  belongs_to :countdown_user
  
  validates :email_address, :scheduled_send_time, presence: true
  validates_format_of :email_address, with: /@/, message: 'Must be a valid email address'
end
