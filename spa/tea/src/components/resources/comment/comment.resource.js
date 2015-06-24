'use strict';

angular.module('tea')
  .factory('Comment', function (teaResource) {
    return teaResource('api/comment/:id',
        {
          id: '@id',
        },{
          newComment: {
            method: 'POST',
            url: 'api/comment/:parentId',
            isArray: false,
            params: {
              parentId: '@parentId',
            },
          },
          summary: {
            method: 'GET',
            url: 'api/comments/:parentId',
            isArray: false,
            params: {
              parentId: '@parentId',
            },
          },
          edit: {
            method: 'PUT',
            url: 'api/comment/:id',
            isArray: false,
            params: {
              parentId: '@id',
            },
          },
        });
  });
