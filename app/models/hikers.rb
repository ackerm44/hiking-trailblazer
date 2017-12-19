class Hiker < ActiveRecord::Base
  has_many :hikers_trails
  has_many :trails, through: :hikers_trails
  has_many :regions, through: :trails
  
  has_secure_password
  
  def slug
  end
end