'use strict';

angular.module('tea')
  .factory('User', function (teaResource) {
    return teaResource('api/user/:id',
        {
          id: '@id',
        },{
          me: {
            method: 'GET',
            url: 'api/user/me',
            isArray: false,
            params: {
            },
          },
        });
  });
