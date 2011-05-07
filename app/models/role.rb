class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  def self.create_role(role_sym)
    rolename = role_sym.to_s.camelize
    unless Role.find_by_name(rolename)
      Role.create!(:name => rolename)
    end
  end
  
  def self.role_for(role_sym)
    Role.find_by_name(role_sym.to_s.camelize)
  end
end
