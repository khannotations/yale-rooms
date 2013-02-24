class Room < ActiveRecord::Base
  has_many :events

  def events_in(start_time, end_time)
    return self.events.where((self.start_time < end_time) & (self.end_time > start_time))
  end
end
