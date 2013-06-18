# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
CountdownImageDescriptor.create({
  name: "default",
  background_image: "timer_template_green.png",
  text_color: "white",
  pointsize: 50,
  width: 360,
  height: 80,
  days_position_x: 30,
  days_position_y: 20,
  hours_position_x: 120,
  hours_position_y: 20,
  minutes_position_x: 210,
  minutes_position_y: 20,
  seconds_position_x: 300,
  seconds_position_y: 20
  }

)
