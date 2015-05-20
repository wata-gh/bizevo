'use strict';

angular.module('tea')
  .factory('Party', function ($resource) {
    return $resource('/api/tea/detail/:id',
        {
          id: '@id',
        },{
          query: {
            method: 'GET',
            url: '/api/tea/list',
            isArray: true,
            params: {
              index: 0,
              size: 10,
            },
          },
        });
  });