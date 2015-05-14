'use strict';

angular.module('tea')
  .factory('tdkService', function ($rootScope) {
    var _title = '';
    var _description = '';

    var service = {
        getTitle: function() {
          return _title;
        },
        setTitle: function(title) {
          _title = (title ? title + ' | ' : '') + 'TeaParty in bizevo';
          $rootScope.$broadcast('setTeaTitle', _title);
        },
        getDescription: function() {
          return _description;
        },
        setDescription: function(description) {
          _description = description ? description : '';
          $rootScope.$broadcast('setTeaDescription', _description);
        },
    };

    $rootScope.$on('$stateChangeSuccess', function(event, state) {
      service.setTitle(state.title);
      service.setDescription(state.description);
    });

    return service;
  })
  .directive('teaTitle', function($rootScope, tdkService){
    return {
      restrict: 'A',
      link: function(scope, element) {
        $rootScope.$on('setTeaTitle', function(event, title) {
          element.text(tdkService.getTitle());
        });
        $rootScope.$on('setTeaDescription', function(event, title) {
          element.attr('content', tdkService.getDescription())
        });
      },
    };
  })
.directive('teaDescription', function($rootScope, tdkService){
  return {
    restrict: 'A',
    link: function(scope, element) {
      $rootScope.$on('setTeaDescription', function(event, title) {
        element.attr('content', tdkService.getDescription())
      });
      $rootScope.$on('setTeaDescription', function(event, title) {
        element.attr('content', tdkService.getDescription())
      });
    },
  };
});
