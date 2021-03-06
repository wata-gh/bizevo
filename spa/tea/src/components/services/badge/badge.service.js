'use strict';

angular.module('tea')
  .factory('badgeService', function ($rootScope) {
    var _badgeInfos = {};
    return {
        regist: function(key, callback) {
          $rootScope.$on('setTeaBadge:' + key, function(event, data) {
            callback(event, data);
          });
        },
        setBadge: function(key, val) {
          _badgeInfos[key] = val;
          $rootScope.$broadcast('setTeaBadge:' + key, val);
        },
        getBadge: function(key) {
          return _badgeInfos[key] && _badgeInfos[key] != 0 ? _badgeInfos[key] : '';
        },
    };
  });