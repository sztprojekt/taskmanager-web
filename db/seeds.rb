# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['registered', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

unless User.count > 0
  role_admin = Role.find_by_name 'admin'
  User.create({ email: 'admin@example.com', password: 'admin12345', role: role_admin})
end

