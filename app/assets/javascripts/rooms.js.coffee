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

@EventsCtrl = ["$scope", "$routeParams", "Events", ($scope, $routeParams, Events) ->
  date = $routeParams.date || "today"
  date = moment().format("YYYY-MM-DD") if date is "today"
  # period = $routeParams.period || "week"
  name = $routeParams.name || ""
  console.log date, name
  if name is ""
    $scope.rooms = Events.query(date: date, (data) ->
      console.log data
    )
  else
    $scope.room = Events.get(name: name, date: date)


  # console.log $scope.room, $scope.rooms

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
    start = moment(e.start_time).format("h:mm a")
    end = moment(e.end_time).format("h:mm a")
    $(".modal-body").html("<p><b>Start</b>: #{start}</p><p><b>End</b>: #{end}</p>")
    $("#myModal").modal()

  $scope.newEvent = (room, hour) ->
    $("#myModalLabel").text("New event in #{room.name} #{room.number}")

]
