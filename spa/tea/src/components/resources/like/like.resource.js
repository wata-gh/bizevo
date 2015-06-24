'use strict';

angular.module('tea')
  .factory('Like', function (teaResource) {
    return teaResource('api/like/:id',
        {
          id: '@id',
        },{
        });
  });
