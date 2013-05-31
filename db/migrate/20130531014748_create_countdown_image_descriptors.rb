class CreateCountdownImageDescriptors < ActiveRecord::Migration
  def change
    create_table :countdown_image_descriptors do |t|
      t.string :background_image
      t.string :background_color
      t.string :text_color
      t.integer :pointsize
      t.string :font_weight
      t.integer :width
      t.integer :height
      t.integer :days_position_x
      t.integer :days_position_y
      t.integer :hours_position_x
      t.integer :hours_position_y
      t.integer :minutes_position_x
      t.integer :minutes_position_y
      t.integer :seconds_position_x
      t.integer :seconds_position_y

      t.timestamps
    end
  end
end
