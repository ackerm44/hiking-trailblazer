class Region < ActiveRecord::Base
  has_many :trails
  has_many :hikers, through: :trails
end