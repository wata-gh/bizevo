'use strict';

angular.module('tea')
  .factory('loadingService', function ($q, $modal) {
    var _loadingCount = 0;
    var _loadingModal = $modal({
      show: false,
      backdrop: 'static',
      animation: 'am-fade-and-slide-top',
      placement: 'center',
      keyboard: false,
      template: 'components/loading/loading.modal.html',
    });
    var _errorModal = $modal({
      show: false,
      backdrop: 'static',
      animation: 'am-fade-and-slide-top',
      placement: 'center',
      keyboard: false,
      template: 'components/loading/error.modal.html',
    });
    return {
        start: function() {
          if (++_loadingCount > 1) {
            return $q.defer().primise;
          }
          return _loadingModal.$promise.then(_loadingModal.show);
        },
        end: function() {
          if (--_loadingCount < 0) {
            _loadingCount = 0;
          }
          if (_loadingCount > 0) {
            return $q.defer().primise;
          }
          return _loadingModal.$promise.then(_loadingModal.hide);
        },
        error: function(status, message, title) {
          if (_errorModal.$isShown) {
            return $q.defer().primise;
          }
          var localMessage = null;
          var localTitle = null;
          if (status == 401) {
            localTitle = 'セッションが切れました';
            localMessage = '再度ログインを行ってください。';
          } else if (status == 404) {
            localTitle = 'ページが見つかりません';
            localMessage = 'お探しのページは見つかりませんでした。';
          } else if (status == 403) {
            localTitle = '権限がありません';
            localMessage = 'このページを表示する権限がありません。';
          } else {
            localTitle = 'エラーが発生しました';
            localMessage = '通信中に予期せぬエラーが発生しました。';
          }
          _errorModal.$scope.title = title || localTitle;
          _errorModal.$scope.content = message || localMessage;

          return _errorModal.$promise.then(_errorModal.show);
        },
    };
  });
