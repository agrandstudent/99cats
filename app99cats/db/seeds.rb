# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

c1 = Cat.create(:name => 'Ajax', :age => 5, :color => "Brown", :sex => "M")
c2 = Cat.create(:name => 'Simba', :age => 2, :color => "Gold", :sex => "M")
c3 = Cat.create(:name => 'Long Cat', :age => 7, :color => "White", :sex => "F")
c4 = Cat.create(:name => 'Mufasa', :age => 3, :color => "Black", :sex => "M")
c5 = Cat.create(:name => 'Hanna', :age => 5, :color => "Calico", :sex => "F")