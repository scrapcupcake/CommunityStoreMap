class StoreSearch
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :near, :game_systems
  
  def initialize(attributes = {})
    self.near = attributes[:near]
    if attributes.has_key? :game_systems
      game_sys = attributes[:game_systems]
      game_sys.delete_if{ |gs| gs.to_i <= 0 }
      self.game_systems = GameSystem.find(game_sys)
    else
      self.game_systems = GameSystem.all
    end
  end
  
  def available_game_systems
    GameSystem.all #.map{ |gs| [true, gs]}
  end
  
  def persisted?
    false
  end
end