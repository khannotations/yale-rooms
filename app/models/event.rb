class Event < ActiveRecord::Base

  belongs_to :organization
  has_and_belongs_to_many :users, :through => :organizations
  belongs_to :room

  geocoded_by :location
  after_validation :geocode
end
