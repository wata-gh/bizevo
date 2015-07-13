'use strict';

angular.module('tea')
  .controller('ListCtrl', function ($scope, Party, likeService, personListModalService, $state, $stateParams) {
    $scope.items = [];

    var page = $stateParams.page || 0;
    var _hasNext = false;
    var _startIndex = 0 * page;
    var _size = 10;
    $scope.hasNext = function() {
      return _hasNext;
    };

    $scope.loadMore = function() {
      var params = {
          index: _startIndex,
          size: _size,
      };

      var unloadOpts = {
          reload: false,
          location: true,
          notify: false,
      };
      var stateParam = {
          q: $stateParams.q,
          tag: $stateParams.tag,
          owner: $stateParams.owner,
          sort: $stateParams.sort,
      };
      if (page) {
        stateParam['page'] = page;
      }
      console.log(stateParam);
      $state.go($state.$current, stateParam, unloadOpts).then(function(){
        var items = Party.query(params, function(){
          _hasNext = items.length >= _size;
          _startIndex += items.length;
          if (!items.length) {
            return;
          }

          for (var i = 0; i < items.length; i++) {
            $scope.items.push(items[i]);
          }
          page++;
        });
      });
    };
    $scope.loadMore();

    $scope.likeParty = likeService.likeItem;

    $scope.likedModal = function(item) {
      var modal = personListModalService.createModal(item.likes.liked, 'いいねした人一覧')
      modal.$promise.then(modal.show);
    };
  });
