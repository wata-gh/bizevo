'use strict';

angular.module('tea')
  .directive('teaDescription', function($rootScope, tdkService){
    return {
      restrict: 'A',
      link: function(scope, element) {
        $rootScope.$on('setTeaDescription', function(event, title) {
          element.attr('content', tdkService.getDescription());
        });
        $rootScope.$on('setTeaDescription', function(event, title) {
          element.attr('content', tdkService.getDescription());
        });
      },
    };
  });
