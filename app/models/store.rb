class Store < ActiveRecord::Base  
  class GeolocException < Exception
  end
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
  
  def self.search(search)
    stores = self.approved
    if search.near and not search.near.empty?
      stores = stores.near(search.near)
    end
    if search.game_systems
      stores = stores.joins(:game_systems).where(:game_systems => {:id => search.game_systems})
      stores = stores.group('stores.id, stores.name, stores.address, stores.lat, stores.lng, stores.email, stores.phone_number, stores.description, stores.hours, stores.approved, stores.url')
    end
    stores
  end
  
  def self.near(location, distance = 0)
    distance = 50 unless distance > 0
    stores = Store.approved.within(distance, :origin => find_origin(location) )
    if stores.count == 0
      raise GeolocException, "Unable to find any stores near that location, please check your spelling and try again"
    else
      stores
    end
  end
  
  private
  def self.find_origin(location)
    loc = Geokit::Geocoders::GoogleGeocoder.geocode(location)
    if loc.success
      [loc.lat, loc.lng]
    else
      raise GeolocException, "Unable to find location, please check your spelling and try again"
    end
  end
  
end