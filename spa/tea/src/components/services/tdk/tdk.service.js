'use strict';

angular.module('tea')
  .factory('tdkService', function ($rootScope) {
    var _title = '';
    var _description = '';

    var service = {
        getTitle: function() {
          return (_title ? _title + ' | ' : '') + 'TeaParty in bizevo';
        },
        getPlaneTitle: function() {
            return _title;
        },
        setTitle: function(title) {
          _title = title;
          return $rootScope.$broadcast('setTeaTitle', _title);
        },
        getDescription: function() {
          return _description;
        },
        setDescription: function(description) {
          _description = description ? description : '';
          return $rootScope.$broadcast('setTeaDescription', _description);
        },
    };

    $rootScope.$on('$stateChangeSuccess', function(event, state) {
      service.setTitle(state.title);
      service.setDescription(state.description);
    });

    return service;
  });