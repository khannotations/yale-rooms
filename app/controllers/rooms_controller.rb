class RoomsController < ApplicationController
  respond_to :json

  # All rooms
  def index
    rooms = []
    Room.all.each do |r|
      events = r.events_in(params[:date], params[:period])
      r[:events] = events
      rooms << r
    end
    puts "\n\n\n\n"
    p rooms
    respond_with rooms
  end

  # One room
  def show
    name = params[:name].split "-"
    rm = name[0]
    num = name[1]
    room = Room.get_room_with_events(rm, num, params[:date])
    respond_with room
  end
  
end
