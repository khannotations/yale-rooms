@reserve.factory "Rooms", ["$resource", ($resource) ->
  $resource("/rooms/:name/:date/:period", 
    {
      name: "all"
      date: moment().format("YYYY-MM-DD")
      period: "week"
    },
    {
      update: { method: "PUT" }
    }
  )
]

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

  $scope.formatTime = (time) ->
    moment(time).format("MM-DD-YYYY")

  $scope.eventStyle = (start, end) ->
    t_start = moment(start)
    hour_start = t_start.hour()
    minute_start = t_start.minute()
    t_end = moment(end)
    diff_hour = t_end.hour() - hour_start
    diff_minute = t_end.minute() - minute_start
    left = hour_start * 4.16 + minute_start*0.07
    width = diff_hour * 4.16 + diff_minute*0.07
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
