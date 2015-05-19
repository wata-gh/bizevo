'use strict';

angular.module('tea')
  .factory('Party', function ($resource) {
    return $resource('/api/tea/detail/:id',
        {
          id: '@id',
        },{
        });
  });