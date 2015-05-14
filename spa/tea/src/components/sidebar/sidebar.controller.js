'use strict';

angular.module('tea')
  .controller('SidebarCtrl', function ($scope, $state) {
    $scope.$state = $state;
  });