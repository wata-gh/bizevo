'use strict';

angular.module('tea')
  .controller('EditCtrl', function ($scope, $state, $stateParams, Party, Upload, confirmModalService, $alert, analyticsService) {

    var id = $stateParams.id;
    if (!id) {
      Party.get({id: 'new'}).$promise.then(function(item){
        $state.go('edit', {id: item.id});
      });
      return;
    }

    Party.get({id: id}).$promise.then(function(item){
      $scope.item = item;
      var isNewPost = item.status === 'unsaved';
      if (isNewPost) {
        item.status = 'draft';
      }

      $scope.likedModal = function(item) {
        return {
          title: 'いいねした人一覧',
          persons: item.likes.liked,
        };
      };

      $scope.saveConfirm = confirmModalService.createConfirm(function(scope){
        Party.save($scope.item).$promise.then(function(item){
          if (item.errors) {
            $scope.errors = item.errors;
            $scope.errorMessages = item.messages;
            $alert({
              content: '入力エラーがあります',
              type: 'danger',
              placement: 'top-right',
            }).$show();
          } else {
            $state.go('detail', {id: item.id});
          }
        });
      }, '確認', '保存しますか？', {});
      $scope.cancelConfirm = confirmModalService.createConfirm(function(scope){
        if (isNewPost) {
          $state.go('list');
        } else {
          $state.go('detail', {id: item.id});
        }
      }, '確認', '保存せずに終了しますか？', {});

      analyticsService.pageTrack();
    });

    $scope.allTags = [];
    $scope.findTags = function(term) {
      $scope.allTags = ['Java', 'JavaScript', 'JavaCoffeeBaby'];
    };

    $scope.imgFiles = [];
    $scope.$watch('imgFiles', function () {
      $scope.uploadImg($scope.imgFiles);
    });
    $scope.uploadImg = function (imgFiles) {
      if (imgFiles && imgFiles.length) {
        for (var i = 0; i < imgFiles.length; i++) {
          $scope.tmpImage = imgFiles[i];
          break;
          Upload.upload({
            url: 'upload/url',
            fields: {'username': $scope.username},
            file: file
          }).progress(function (evt) {
            var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            console.log('progress: ' + progressPercentage + '% ' + evt.config.file.name);
          }).success(function (data, status, headers, config) {
            console.log('file ' + config.file.name + 'uploaded. Response: ' + data);
          });
        }
      }
    };
  });
