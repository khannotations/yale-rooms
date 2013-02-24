class Room < ActiveRecord::Base
  has_many :events

  geocoded_by :location
  after_validation :geocode

  def as_json(options={})
    {
      "name" => name,
      "location" => location,
      "events" => events,
      "number" => number
    }
  end

  def Room.get_room_with_events(rm, num, date, period) 
    room = Room.where(name: rm, number: num).first
    return [] if not room.empty?
    events = room.events_in(params[:date], params[:period])
    room[:events] = events
  end


  def events_in(t_start, period)
    ps = t_start.split("-")
    now = Time.new(ps[0].to_i, ps[1].to_i, ps[2].to_i, 0, 0, 0, "-05:00")
    if period == "week"
      t_end = now+1.week
    else
      t_end = now+1.day
    end
    return self.events.where("start_time < ? AND end_time > ?", t_start, t_end)
  end

  def Room.all_events_in(t_start, period)
    ps = t_start.split("-")
    now = Time.new(ps[0].to_i, ps[1].to_i, ps[2].to_i, 0, 0, 0,"-05:00")
    if period == "week"
      t_end = now+1.week
    else
      t_end = now+1.day
    end
    return Events.where(start_time < t_end & end_time > t_start)
  end
end
