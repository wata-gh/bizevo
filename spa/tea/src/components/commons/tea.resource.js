'use strict';

angular.module('tea')
  .factory('teaResource', function ($resource) {
    return function(url, paramDefaults, actions){
      var defaultActions = { // default actions from AngularJS.
        'get':    {method:'GET'},
        'save':   {method:'POST'},
        'query':  {method:'GET', isArray:true},
        'remove': {method:'DELETE'},
        'delete': {method:'DELETE'},
      };
      var customActions = angular.extend({}, defaultActions, actions);
      for (var key in customActions) {
        var h = angular.extend({}, customActions[key], {
          transformResponse: function(data, headers) {
            if (!/application\/json/i.test(headers("Content-Type"))) {
              return data;
            }
            return angular.fromJson(data).results;
          },
        });
        customActions[key] = h;
      }
      return $resource(url, paramDefaults, customActions);
    }
  });