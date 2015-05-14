'use strict';

angular.module('tea')
  .factory('badgeService', function ($rootScope) {
    var badgeInfos = {};
    var service = {
        regist: function(key, callback) {
          $rootScope.$on('setTeaBadge:' + key, function(event, data) {
            callback(event, data);
          });
        },
        setBadge: function(key, val) {
          badgeInfos[key] = val;
          $rootScope.$broadcast('setTeaBadge:' + key, val);
        },
        getBadge: function(key) {
          return badgeInfos[key] && badgeInfos[key] != 0 ? badgeInfos[key] : '';
        },
    };
    return service;
  })
  .directive('teaBadge', function($rootScope, badgeService){
    return {
      restrict: 'A',
      link: function(scope, element, attrs) {
        var key = attrs.teaBadge;
        badgeService.regist(key, function(){
          element.text(badgeService.getBadge(key));
        });
      },
    };
  });