@reserve.factory "User", ["$resource", ($resource) ->
  $resource("/user")
]

@UsersCtrl = ["$scope", "User", ($scope, User) ->
  $scope.me = User.get()
]