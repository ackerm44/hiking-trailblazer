class Trail < ActiveRecord::Base
  belongs_to :region
  has_many :hikers_trails
  has_many :hikers, through: :hikers_trails
  
  def slug
  end
end