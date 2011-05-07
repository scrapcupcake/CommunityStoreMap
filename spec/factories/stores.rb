Factory.define :store do |f|
  f.sequence(:name) { |n| "gaming_store#{n}" }
  f.url { |s| "http://#{s.name}" }
  f.sequence(:address) { |n| "#{n*100} W Main St, Hillsboro, OR"}
  f.description "Test"
  f.lat 1.5
  f.lng 1.5
  f.approved true
end