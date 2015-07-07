'use strict';

angular.module('tea')
  .controller('TopCtrl', function (analyticsService) {
    analyticsService.pageTrack();
  });
