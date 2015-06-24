'use strict';

angular.module('tea')
  .factory('Attend', function (teaResource) {
    return teaResource('api/attend/:id',
        {
          id: '@id',
        },{
        });
  });
