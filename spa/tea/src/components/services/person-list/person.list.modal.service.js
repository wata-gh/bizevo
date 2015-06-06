'use strict';

angular.module('tea')
  .factory('personListModalService', function ($rootScope, $modal) {
    return {
      createModal: function(persons, title, options) {
        options = options || {};
        var scope = $rootScope.$new(true);
        options.template = 'components/templates/person-list/list.modal.html';
        options.show = false;
        options.scope = scope;
        options.container = 'body';
        options.animation = 'am-fade-and-slide-top';

        var modal = $modal(options);

        scope.title = title;
        scope.persons = persons;

        return modal;
      },
    };
  });