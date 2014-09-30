# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP DEFAULT USER LOGIN'
print "Enter admin email: "
admin_email = 'admin@answers.gsa.io'

user = Answers::User.create! :email => admin_email, :password => 'Mahalo43', :password_confirmation => 'Mahalo43', :is_admin => true, :is_editor => true, :is_writer => true
puts 'New user created: ' << user.email
puts "Admin password has been set to: Mahalo43"
