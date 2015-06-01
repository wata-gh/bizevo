'use strict';

angular.module('tea')
  .factory('confirmModalService', function ($rootScope, $modal) {
    return {
      createConfirm: function(success, title, content, options) {
        options = options || {};
        var scope = $rootScope.$new(true);
        options.template = 'components/templates/confirm/confirm.modal.html';
        options.show = false;
        options.scope = scope;

        var modal = $modal(options);

        scope.title = title;
        scope.content = content;
        scope.okConfirm = function() {
          success(scope);
          modal.hide();
        };

        return {
          confirm: function() {
            modal.$promise.then(modal.show);
          },
        };
      },
    };
  });