'use strict';

angular.module('tea')
  .factory('likeService', function (Like) {
    return {
      likeItem: function(item) {
        var like = new Like({id: item.id});
        var callback = function(likes) {
          item.likes = likes;
        };
        return item.likes.isLiked ? like.$delete(callback) : like.$save(callback);
      }
    };
  });