class Event < ActiveRecord::Base

  belongs_to :organization
  has_many :users, :through => :organizations
  belongs_to :room

  def as_json(options={})
    {
      end_time: end_time,
      id: id,
      name: name,
      organization_name: organization.name,
      room_name: room.name,
      room_number: room.number,
      start_time: start_time
    }
  end
end
