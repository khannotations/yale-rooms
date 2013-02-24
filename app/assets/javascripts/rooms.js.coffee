@reserve.factory "Events", ["$resource", ($resource) ->
  $resource("/events/:date/:name", 
    {
      date: moment().format("YYYY-MM-DD")
      name: ""
    },
    {
      update: { method: "PUT" }
    }
  )
]

# <<<<<<< HEAD
# @EventsCtrl = ["$scope", "$routeParams", "Events", ($scope, $routeParams, Events) ->
#   date = $routeParams.date || "today"
#   date = moment().format("YYYY-MM-DD") if date is "today"
#   # period = $routeParams.period || "week"
#   name = $routeParams.name || ""
#   console.log date, name
#   if name is ""
#     $scope.rooms = Events.query(date: date, (data) ->
#       console.log data
#     )
#   else
#     $scope.room = Events.get(name: name, date: date)


#   # console.log $scope.room, $scope.rooms
# =======
@RoomsCtrl = ["$scope", "$routeParams", "Rooms", ($scope, $routeParams, Rooms) ->
  t = this

  date = $routeParams.date || "today"
  date = moment().format("YYYY-MM-DD") if date is "today"
  t.date = date
  period = $routeParams.period || "week"
  name = $routeParams.name || "all"
  console.log name, date, period
  if name is "all"
    $scope.rooms = Rooms.query(name: "all", date: date, period: period)
  else
    $scope.rooms = []
    $scope.room = Rooms.get(name: name, date: date, period: period)
    $scope.rooms.push $scope.room

  $scope.eventClass = (e) ->
    "event-#{e.id}"
  $scope.formatTime = (time) ->
    moment(time).format("MM-DD-YYYY")

  $scope.eventStyle = (start, end) ->

    start = moment(start)
    end = moment(end)
    start_hour = start.hour()
    diff_hour = end.hour() - start_hour
    start_min = start.minute()
    diff_min = end.minute() - start_min
    left = start_hour * 4.16 + start_min*0.07
    width = diff_hour * 4.16 + diff_min*0.07
    style = {
      left: left+"%"
      width: width+"%"
    }
    return style

  $scope.modal = (e) ->
    $("#myModalLabel").text(e.name)
    t_start = moment(e.start_time).format("h:mm a")
    t_end = moment(e.end_time).format("h:mm a")
    $(".modal-body").html("<p><b>Start:</b> #{t_start}</p><p><b>End:</b> #{t_end}</p>")
    $("#myModal").modal()

  $scope.newEvent = (room, hour) ->
    $("#myModalLabel").text("Reserving #{room.name} #{room.number}")
    hour = 12 if hour is 0
    $(".modal-body").html("<b>Organization</b>: &nbsp; &nbsp;&nbsp;<select><option value='yale'>Yale College</option></select>\
<p><b>Start: &nbsp;</b> <input type='text' value='#{hour}:00 '/></p><p><b>End: &nbsp; &nbsp;&nbsp;</b><input type='text' /></p>")
    $("#myModal").modal()
  ]
