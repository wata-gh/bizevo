'use strict';

angular.module('tea')
  .controller('ListCtrl', function ($scope) {
    $scope.items = [];

    var _hasNext = false;
    $scope.hasNext = function() {
      return _hasNext;
    };

    $scope.loadMore = function() {
      
      var last = $scope.items.length;
      for (var i = last; i < last + 10; i++) {
        /*
         * ＜アイテムデータモデル案＞
         * ID
         * 画像
         * タイトル
         * 詳細
         * いいね
         *  いいね数
         *  いいねした人
         *   ID、名前、画像
         *  いいねしたかフラグ
         * タグ一覧
         *  タグ名、IDは不要か？
         * 開催日時
         * 開催場所
         * 参加予定人数
         * 参加予定者
         *  ID、名前、画像
         * 更新日時
         * コメント
         *  コメント数
         *  コメント一覧
         *   コメント本文
         *   コメント者
         *    ID、名前、画像
         *   いいね
         *    いいね数
         *    いいねした人
         *     ID、名前、画像
         *    いいねしたかフラグ
         */
        var img = 'https://pbs.twimg.com/profile_images/2579542348/l2b371d8r57tu6m4wu7i_400x400.jpeg';
        var person = {id: 999, name: 'たろう', image: img};
        var likes = {
            count: 1,
            isLiked: i % 2 == 0 ? false : true,
            liked: [
              person,
            ],
          };
        $scope.items.push({
          id: 123,
          image: img,
          title: 'タイトル' + i,
          description: 'ほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげほげ' + "\n" + 'ふがふがふがふがふがふがふがふがふが',
          likes: likes,
          tags: [
           'Java', 'Ruby', 'AngularJS'
          ],
          dates: '2009/08/11 08:14:45',
          venue: '6F研修室',
          reseratin: 'http://www.google.com/',
          attendees: {
            count: 10,
            isAttended: i % 2 == 0 ? false : true,
            attended: [
              person,
            ],
          },
          comments: {
            count: 10,
            items: [
              {
                comment: "こめんと\n改行\nこめんと",
                auther: person,
                date: '2009/08/11 08:14:45',
                likes: likes,
              }
            ]
          }
        });
      }
      _hasNext = $scope.items.length < 300;
    };
    $scope.loadMore();
    $scope.loadMore();
    $scope.loadMore();

    $scope.likeParty = function(item) {
      item.likes.isLiked = !item.likes.isLiked;
      item.likes.count += 1;
    };
  });
