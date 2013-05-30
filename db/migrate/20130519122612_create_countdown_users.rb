class CreateCountdownUsers < ActiveRecord::Migration
  def change
    create_table :countdown_users do |t|
      t.integer :cookie_identifier
      t.string :time
      t.string :email
      t.string :timer_title

      t.timestamps
    end
  end
end
