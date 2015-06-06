'use strict';

angular.module('tea')
  .factory('myService', function (User) {
    var _me = null;
    return {
      getMe: function() {
        return _me;
      },
      initMe: function() {
        _me = User.me();
        return _me;
      }
    };
  })
  .run(function(myService){
    return myService.initMe().$promise;
  });