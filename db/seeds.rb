# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if(Plan.count == 0)
	Plan.create(name: "Daily", registration_limit: 50, price: 200, description: "This is daily plan.")
	Plan.create(name: "Weekly", registration_limit: 50, price: 1200, description: "This is weekly plan.")
	Plan.create(name: "Monthly", registration_limit: 50, price: 1000, description: "This is monthly plan.")
	Plan.create(name: "Quaterly", registration_limit: 50, price: 12000, description: "This is quaterly plan.")
	Plan.create(name: "Yearly", registration_limit: 50, price: 15000, description: "This is yearly plan.")
end