Factory.define :store do |f|
  f.sequence(:name) { |n| "gaming_store#{n}" }
  f.url { |s| "http://#{s.name}" }
  f.description "Test"
  f.lat 1.5
  f.lng 1.5
end