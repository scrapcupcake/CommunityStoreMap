class Store < ActiveRecord::Base
  acts_as_mappable
  has_and_belongs_to_many :game_systems
  before_validation :address_to_latlng
  after_validation :give_latlng_errors_to_address, :if => lambda{ |obj| obj.address_changed? }
  
  validates_presence_of :name, :description, :address, :phone_number
  validates_numericality_of :lat, :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90
  validates_numericality_of :lng, :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180
  validates_uniqueness_of :lat, :scope => :lng, :message => "must be a unique location"
  validates_uniqueness_of :address #should I add email and phone_number?
  
  scope :approved, where(:approved => true)
  scope :unapproved, where(:approved => false)
  
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
  
  def self.stores_near(location, distance)
    loc = Geokit::Geocoders::GoogleGeocoder.geocode(location)
    if loc.success
      return Store.approved.within(distance, :origin => [loc.lat, loc.lng])
    else
      return nil #Should raise an exception here instead, really, because the above will return nil, too
    end
  end
end
