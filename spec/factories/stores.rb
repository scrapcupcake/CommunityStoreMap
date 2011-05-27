Factory.define :store do |f|
  f.sequence(:name) { |n| "gaming_store#{n}" }
  f.url { |s| "http://#{s.name}" }
  f.sequence(:address) { |n| "#{n*100} W Main St, Hillsboro, OR"}
  f.description "Test"
  f.lat 1.5
  f.lng 1.5
  f.approved true
  f.game_systems ["Warmachine/Hordes", "Malifaux", "Firestorm Armada"].map { 
      |game| GameSystem.find_or_create_by_name(Factory.attributes_for(:game_system, :name => game))
    }
  f.hours ["Monday-Thursday 10:00am-7:00pm", "Friday 10:00am-9:00pm", "Saturday 11:00am-11:00am"].join("\n")
  f.phone_number "555-555-5555"
  f.email "storeowner@example.com"
end