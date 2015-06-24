'use strict';

angular.module('tea')
  .factory('Comments', function (teaResource) {
    return teaResource('api/comments/:id',
        {
          id: '@id',
        },{
        });
  });
