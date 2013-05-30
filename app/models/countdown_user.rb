class CountdownUser < ActiveRecord::Base
  has_one :user_scheduled_email, dependent: :destroy
end
