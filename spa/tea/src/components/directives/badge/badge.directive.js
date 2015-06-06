'use strict';

angular.module('tea')
  .directive('teaBadge', function($rootScope, badgeService){
    return {
      restrict: 'A',
      link: function(scope, element, attrs) {
        badgeService.regist(attrs.teaBadge, function(){
          element.text(badgeService.getBadge(attrs.teaBadge));
        });
      },
    };
  });