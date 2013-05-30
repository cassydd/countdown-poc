class ChangeCookieIdentifierInCountdownUsers < ActiveRecord::Migration
  def change
    change_column :countdown_users, :cookie_identifier, :string
  end
end
