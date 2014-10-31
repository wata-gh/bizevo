'use strict';

angular.module('tea')
  .controller('NavbarCtrl', ['$scope', function ($scope) {
    $scope.date = new Date();
  }]);
