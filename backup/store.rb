class Store < ActiveRecord::Base
  acts_as_mappable
  
  def self.optimal_origin
    bounds = optimal_bounds
    lat = bounds[:ne][0] + ((bounds[:sw][0] - bounds[:ne][0]) /2)
    lng = bounds[:ne][1] + ((bounds[:sw][1] - bounds[:ne][1]) /2)
    [lat,lng]
  end
  
  def self.optimal_bounds
    n = Store.maximum('lat')
    s = Store.minimum('lat')
    e = Store.maximum('lng')
    w = Store.minimum('lng')
    
    bounds = {:ne => [n,e], :sw => [s,w]}
  end
end
