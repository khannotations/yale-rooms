class Event < ActiveRecord::Base

  belongs_to :organization
  has_many :users, :through => :organizations
  belongs_to :room
end
