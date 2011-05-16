class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :role_ids
  #accepts_nested_attributes_for :roles #apparently doesn't work w/ habtm
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  def grant_role(role)
    self.roles << Role.role_for(role)
  end
end
