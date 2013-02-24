@reserve.factory "User", ["$resource", ($resource) ->
  $resource("/user")
]

@reserve.factory "Event", ["$resource", ($resource) ->
  $resource("/organization/:o_id/event/:e_id")
]

@UsersCtrl = ["$scope", "User", ($scope, User) ->
  $scope.me = User.get()
  $.get("/organizations/1/events", (data) ->
    console.log data
    $scope.events = data
  )
  $scope.formatTimeLong = (time) ->
    moment(time).format("dddd, MMMM Do YYYY, h:mm:ss a")
  console.log $scope.events
]