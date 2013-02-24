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
  date = $routeParams.date || "today"
  date = moment().format("YYYY-MM-DD") if date is "today"
  period = $routeParams.period || "week"
  name = $routeParams.name || "all"
  console.log name, date, period
  if name is "all"
    $scope.rooms = Rooms.query(name: "all", date: date, period: period)
  else
    $scope.room = Rooms.get(name: name, date: date, period: period)


  console.log $scope.room, $scope.rooms


  $scope.formatTime = (time) ->
    moment(time).format("MM-DD-YYYY")

  $scope.tableLeft = (time, period) ->
    time = moment(time)
    hour = time.hour()
    minute = time.minute()
    left = hour * 4.16 + minute*0.07
    style  = "{color: 'red';}"
    console.log style
    return style
    # "{left: #{left}%;}"
]
