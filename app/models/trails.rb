class Trail < ActiveRecord::Base
  belongs_to :region
  has_many :hikers_trails
  has_many :hikers, through: :hikers_trails
  
  def slug
    name.downcase.gsub(/[\s.'&+]/, '-')
  end
  
  def self.find_by_slug(slug)
    self.all.select {|name| name.slug == slug}.last
  end
end