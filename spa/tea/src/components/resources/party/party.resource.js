'use strict';

angular.module('tea')
  .factory('Party', function (teaResource) {
    return teaResource('api/party/:id',
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
