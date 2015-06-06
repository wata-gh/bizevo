'use strict';

angular.module('tea')
  .controller('ListCtrl', function ($scope, Party, personListModalService) {
    $scope.items = [];

    var _hasNext = false;
    var _startIndex = 0;
    var _size = 10;
    $scope.hasNext = function() {
      return _hasNext;
    };

    $scope.loadMore = function() {
      var params = {
          index: _startIndex,
          size: _size,
      };
      var items = Party.query(params, function(){
        _hasNext = items.length >= _size;
        _startIndex += items.length;
        if (!items.length) {
          return;
        }

        for (var i = 0; i < items.length; i++) {
          $scope.items.push(items[i]);
        }
      });
    };
    $scope.loadMore();

    $scope.likeParty = function(item) {
      item.likes.isLiked = !item.likes.isLiked;
      item.likes.count += 1;
    };

    $scope.likedModal = function(item) {
      var modal = personListModalService.createModal(item.likes.liked, 'いいねした人一覧')
      modal.$promise.then(modal.show);
    };
  });
