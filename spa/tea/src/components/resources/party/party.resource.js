'use strict';

angular.module('tea')
  .factory('Party', function ($resource) {
    return $resource('api/party/:id',
        {
          id: '@id',
        },{
          query: {
            method: 'GET',
            url: 'api/party',
            isArray: true,
            params: {
            },
          },
        });
  });
