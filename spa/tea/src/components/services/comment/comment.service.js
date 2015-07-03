'use strict';

angular.module('tea')
  .factory('commentService', function (Comment) {
    var _restoreComments = function(item) {
      var comments = Comment.summary({parentId: item.id}, function(){
        item.comments = comments;
      });
    };

    return {
      postComment: function(item, text) {
        var comment = new Comment({parentId: item.id, text: text});
        return comment.$newComment(function(){
          _restoreComments(item);
        });
      },
      editComment: function(item, comment) {
        var comment = new Comment(comment);
        return comment.$edit(function(){
          _restoreComments(item);
        });
      },
      deleteComment: function(item, comment) {
        var comment = new Comment(comment);
        return comment.$delete(function(){
          _restoreComments(item);
        });
      },
    };
  });