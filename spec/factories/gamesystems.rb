Factory.define :game_system do |f|
  f.sequence(:name) { |n| "Game #{n}"}
  f.url ""
  f.description "Totally Awesome!"
end