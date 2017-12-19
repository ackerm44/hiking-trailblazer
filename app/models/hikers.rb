class Hiker < ActiveRecord::Base
  has_many :hikers_trails
  has_many :trails, through: :hikers_trails
  has_many :regions, through: :trails
  
  has_secure_password
  
  def slug
    username.downcase.gsub(/[\s.'&+]/, '-')
  end
  
  def self.find_by_slug(slug)
    self.all.select {|username| username.slug == slug}.last
  end
end