'use strict';

angular.module('tea')
  .factory('loadingService', function ($q, $modal) {
    var loading_count = 0;
    var loading_modal = $modal({
      show: false,
      backdrop: 'static',
      animation: 'am-fade-and-slide-top',
      placement: 'center',
      keyboard: false,
      template: 'components/loading/loading.modal.html',
    });
    var error_modal = $modal({
      show: false,
      backdrop: 'static',
      animation: 'am-fade-and-slide-top',
      placement: 'center',
      keyboard: false,
      template: 'components/loading/error.modal.html',
    });
    var service = {
        start: function() {
          if (++loading_count > 1) {
            return $q.defer().primise;
          }
          return loading_modal.$promise.then(loading_modal.show);
        },
        end: function() {
          if (--loading_count < 0) {
            loading_count = 0;
          }
          if (loading_modal > 0) {
            return $q.defer().primise;
          }
          return loading_modal.$promise.then(loading_modal.hide);
        },
        error: function(status, message, title) {
          if (error_modal.$isShown) {
            return $q.defer().primise;
          }
          var local_message = null;
          var local_title = null;
          if (status == 401) {
            local_title = 'セッションが切れました';
            local_message = '再度ログインを行ってください。';
          } else if (status == 404) {
            local_title = 'ページが見つかりません';
            local_message = 'お探しのページは見つかりませんでした。';
          } else if (status == 403) {
            local_title = '権限がありません';
            local_message = 'このページを表示する権限がありません。';
          } else {
            local_title = 'エラーが発生しました';
            local_message = '通信中に予期せぬエラーが発生しました。';
          }
          error_modal.$scope.title = title || local_title;
          error_modal.$scope.content = message || local_message;

          return error_modal.$promise.then(error_modal.show);
        },
    };
    return service;
  });
