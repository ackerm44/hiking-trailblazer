class Region < ActiveRecord::Base
  has_many :trails
  has_many :hikers, through: :trails
  
  def slug
    name.downcase.gsub(/[\s.'&+]/, '-')
  end
  
  def self.find_by_slug(slug)
    self.all.select {|name| name.slug == slug}.last
  end
  
end