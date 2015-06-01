'use strict';

angular.module('tea')
  .controller('DetailCtrl', function ($scope, $stateParams, Party, tdkService, confirmModalService, personListModalService) {
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
        var modal = personListModalService.createModal(item.likes.liked, 'いいねした人一覧')
        modal.$promise.then(modal.show);
      };

      $scope.attendedModal = function(item) {
        var modal = personListModalService.createModal(item.attends.liked, '参加者一覧')
        modal.$promise.then(modal.show);
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

      $scope.newComment = '';
      $scope.postComment = function() {
        if (!$scope.newComment) {
          return;
        }
        $scope.item.comments.count += 1;
        $scope.item.comments.commented.push({
          text: $scope.newComment,
          date: '2015/09/01 20:11:23',
          auther: {
            id: 222,
            name: 'さぶろう',
            image: 'https://pbs.twimg.com/profile_images/546511706868822017/-XMTo767_bigger.jpeg',
          },
          likes: {
            count: 0,
            isLiked: false,
            liked: [],
          },
        });
        $scope.newComment = '';
      };
    });
  });
