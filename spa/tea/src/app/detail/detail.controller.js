'use strict';

angular.module('tea')
  .controller('DetailCtrl', function ($scope, $stateParams, Party, tdkService, confirmModalService) {
    var id = $stateParams.id;

    Party.get({id: id}).$promise.then(function(item){
      $scope.item = item;
      tdkService.setTitle(item.title);
      tdkService.setDescription(item.description);

      $scope.likeParty = function(item) {
        item.likes.isLiked = !item.likes.isLiked;
        item.likes.count += 1;
      };

      $scope.likeComment = function(comment) {
        comment.likes.isLiked = !comment.likes.isLiked;
        comment.likes.count += 1;
      };

      $scope.attendParty = function(item) {
        item.attends.isAttended = !item.attends.isAttended;
        item.attends.count += 1;
      };

      $scope.likedModal = function(item) {
        return {
          title: 'いいねした人一覧',
          persons: item.likes.liked,
        };
      };

      $scope.attendedModal = function(item) {
        return {
          title: '参加者一覧',
          persons: item.attends.attended,
        };
      };

      var attendFunction = function(scope) {
        item.attends.count += 1;
        item.attends.isAttended = !item.attends.isAttended;
        return true;
      };
      var confirmOptions = {
      };
      $scope.attendConfirm = confirmModalService.createConfirm(attendFunction, '参加確認', 'この勉強会に参加しますか？', confirmOptions);
      $scope.leaveConfirm = confirmModalService.createConfirm(attendFunction, '不参加確認', 'この勉強会への参加を取りやめますか？', confirmOptions);
    });
  });
