# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Role.create(:name => 'Administrator')

admin_user = User.create(:username => 'Admin', 
                         :email => 'admin@citymask.com',
                         :password => '123456', 
                         :password_confirmation => '123456')
admin_role = Role.find_by_name('Administrator')
admin_user.roles << admin_role
