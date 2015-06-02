'use strict';

angular.module('tea')
  .factory('User', function ($resource) {
    return $resource('api/user/:id',
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
