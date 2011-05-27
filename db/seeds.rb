# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

if User.count == 0
  admin = User.find_or_create_by_email({
          :email => "admin@localhost.localhost",
          :password => "changeme",
          :password_confirmation => "changeme"
          })
  Role.create_role(:admin)
  admin.grant_role(:admin)
end

games = %{Warmachine/Hordes
Malifaux
MERCS
Dystopian Wars
Firestorm Armada
Uncharted Seas
Infinity
Anima Tactics
AE-WWII}

games.split("\n").each do |game|
  GameSystem.find_or_create_by_name({
  :name => game,
  :url => "",
  :description => "Totally Awesome!"
  })
end