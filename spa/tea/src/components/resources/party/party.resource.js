'use strict';

angular.module('tea')
  .factory('Party', function ($resource) {
    return $resource('/api/tea/party/:id',
        {
          id: '@id',
        },{
          query: {
            method: 'GET',
            url: '/api/tea/party',
            isArray: true,
            params: {
            },
          },
        });
  });