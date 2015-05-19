'use strict';

angular.module('tea')
  .controller('DetailCtrl', function ($scope, $stateParams, Party, tdkService, confirmModalService) {
    var id = $stateParams.id;

    Party.get({id: id}).$promise.then(function(item){
      $scope.item = item;
      tdkService.setTitle(item.title);
      tdkService.setDescription(item.description);

      $scope.likeParty = function(item) {
        item.likes.is_liked = !item.likes.is_liked;
        item.likes.count += 1;
      };

      $scope.attendParty = function(item) {
        item.attends.is_attended = !item.attends.is_attended;
        item.attends.count += 1;
      };

      $scope.liked_modal = function(item) {
        return {
          title: 'いいねした人一覧',
          persons: item.likes.liked,
        };
      };

      $scope.attended_modal = function(item) {
        return {
          title: '参加者一覧',
          persons: item.attends.attended,
        };
      };

      var attend_function = function(scope) {
        item.attends.count += 1;
        item.attends.is_attended = !item.attends.is_attended;
        return true;
      };
      var confirm_options = {
      };
      $scope.attend_confirm = confirmModalService.createConfirm(attend_function, '参加確認', 'この勉強会に参加しますか？', confirm_options);
      $scope.leave_confirm = confirmModalService.createConfirm(attend_function, '不参加確認', 'この勉強会への参加を取りやめますか？', confirm_options);
    });
  });
