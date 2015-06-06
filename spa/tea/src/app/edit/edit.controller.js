'use strict';

angular.module('tea')
  .controller('EditCtrl', function ($scope, $state, $stateParams, Party, Upload, confirmModalService) {

    var id = $stateParams.id;
    if (!id) {
      $state.go('edit', {id: 123});
      return;
    }

    Party.get({id: id}).$promise.then(function(item){
      $scope.item = item;
      var isNewPost = item.status === 1;

      $scope.likedModal = function(item) {
        return {
          title: 'いいねした人一覧',
          persons: item.likes.liked,
        };
      };

      $scope.saveConfirm = confirmModalService.createConfirm(function(scope){
        $state.go('detail', {id: item.id});
      }, '確認', '保存しますか？', {});
      $scope.cancelConfirm = confirmModalService.createConfirm(function(scope){
        if (isNewPost) {
          $state.go('list');
        } else {
          $state.go('detail', {id: item.id});
        }
      }, '確認', '保存せずに終了しますか？', {});
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
