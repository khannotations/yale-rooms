class EventsController < ApplicationController
  respond_to :json

  # All rooms
  def index
    ps = params[:date].split("-")
    t_start = Time.new(ps[0].to_i, ps[1].to_i, ps[2].to_i, 0, 0, 0, "-05:00")
    t_end = t_start + 1.day
    events = Event.includes(:room).where("(start_time < ?) AND (end_time > ?)", t_end, t_start)
    grouped_events = events.group_by { |e| e.room.room }
    # rooms = []
    # Room.all.each do |r|
    #   events = r.events_in(params[:date], params[:period])
    #   r[:events] = events
    #   rooms << r
    # end
    # puts "\n\n\n\n"
    # p rooms
    respond_with grouped_events
  end

  # One room
  def show
    ps = params[:date].split("-")
    t_start = Time.new(ps[0].to_i, ps[1].to_i, ps[2].to_i, 0, 0, 0, "-05:00")
    t_end = t_start + 1.day
    events = Event.includes(:rooms).where(start_time < t_end & end_time > t_start)
    selected = []
    rms = params[:name].split("-")
    rm = rms[0]
    num = rms[1]
    events.each do |e|
      selected << e if e.room.name == rm and e.room.number == num
    end
    respond_with selected
  end
end
