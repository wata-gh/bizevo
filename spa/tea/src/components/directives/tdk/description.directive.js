'use strict';

angular.module('tea')
  .directive('teaTitle', function($rootScope, tdkService){
    return {
      restrict: 'A',
      link: function(scope, element) {
        $rootScope.$on('setTeaTitle', function(event, title) {
          element.text(tdkService.getTitle());
        });
      },
    };
  });
