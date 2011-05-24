class Store < ActiveRecord::Base
  acts_as_mappable
  before_validation :address_to_latlng
  after_validation :give_latlng_errors_to_address, :if => lambda{ |obj| obj.address_changed? }
  
  validates_presence_of :name, :description, :address
  validates_numericality_of :lat, :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90
  validates_numericality_of :lng, :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180
  validates_uniqueness_of :lat, :scope => :lng, :message => "must be a unique location"
  validates_uniqueness_of :address
  
  scope :approved, where(:approved => true)  
  scope :unapproved, where(:approved => false)  
  
  def no_latlng
    not ((lat) and (lng))
  end  
  
  def address_to_latlng
      loc = Geokit::Geocoders::GoogleGeocoder.geocode(address)
      if loc and loc.success
        self.lat = loc.lat.to_f
        self.lng = loc.lng.to_f
      else
        errors.add(:address, "Unable to find address, please verify that it is correct and can be found on google maps")
      end
  end
  
  def give_latlng_errors_to_address
    [:lat, :lng].each do |field|
      errors[field].each do |error|
        errors.add(:address, error)
      end
      errors[field].clear
    end
  end
  
  #deprecated, turns out this is handled by jMappable just fine
  def self.optimal_origin
    bounds = optimal_bounds
    lat = bounds[:ne][0] + ((bounds[:sw][0] - bounds[:ne][0]) /2)
    lng = bounds[:ne][1] + ((bounds[:sw][1] - bounds[:ne][1]) /2)
    [lat,lng]
  end
  
  #deprecated, turns out this is handled by jMappable just fine
  def self.optimal_bounds
    n = Store.maximum('lat')
    s = Store.minimum('lat')
    e = Store.maximum('lng')
    w = Store.minimum('lng')
    
    bounds = {:ne => [n,e], :sw => [s,w]}
    bounds
  end
  
  def self.stores_near(location, distance)
    loc = Geokit::Geocoders::GoogleGeocoder.geocode(location)
    if loc.success
      return Store.approved.within(distance, :origin => [loc.lat, loc.lng])
    else
      return nil
    end
  end
end
