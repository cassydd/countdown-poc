class CreateUserScheduledEmails < ActiveRecord::Migration
  def change
    create_table :user_scheduled_emails do |t|
      t.references :countdown_user, index: true
      t.string :email_address
      t.datetime :scheduled_send_time

      t.timestamps
    end
  end
end
