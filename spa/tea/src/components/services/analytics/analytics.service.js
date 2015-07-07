'use strict';

angular.module('tea')
  .factory('analyticsService', function ($analytics, $location) {

    var pageTrack = function(page) {
      page = page || $location.url();
      $analytics.pageTrack(page);
    };

    var service = {
        pageTrack: function(page) {
          return pageTrack(page);
        },
    };
    return service;
  });