'use strict';

angular.module('tea')
  .factory('User', function ($resource) {
    return $resource('/api/tea/user/:id',
        {
          id: '@id',
        },{
          me: {
            method: 'GET',
            url: '/api/tea/user/me',
            isArray: false,
            params: {
            },
          },
        });
  });