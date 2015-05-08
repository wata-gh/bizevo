(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
$(function() {
  $.ajaxPrefilter(function(options, originalOptions, xhr) {
    var token;
    if (!options.crossDomain) {
      token = $('meta[name="csrf-token"]').attr('content');
      if (token) {
        return xhr.setRequestHeader('X-CSRF-Token', token);
      }
    }
  });
  return $.fn.api.settings.api = {
    'update feeling': '/api/feeling/{at}',
    'update comment': '/api/feeling/{id}/comment'
  };
});



},{}]},{},[1])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9ob21lL3dlYnNlcnZpY2UvcHJvamVjdHMvYml6ZXZvL25vZGVfbW9kdWxlcy9ndWxwLWJyb3dzZXJpZnkvbm9kZV9tb2R1bGVzL2Jyb3dzZXJpZnkvbm9kZV9tb2R1bGVzL2Jyb3dzZXItcGFjay9fcHJlbHVkZS5qcyIsIi9ob21lL3dlYnNlcnZpY2UvcHJvamVjdHMvYml6ZXZvL2Fzc2V0cy9qYXZhc2NyaXB0cy9hcHAuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUEsQ0FBQSxDQUFFLFNBQUEsR0FBQTtBQUNBLEVBQUEsQ0FBQyxDQUFDLGFBQUYsQ0FBaUIsU0FBQyxPQUFELEVBQVUsZUFBVixFQUEyQixHQUEzQixHQUFBO0FBQ2YsUUFBQSxLQUFBO0FBQUEsSUFBQSxJQUFHLENBQUEsT0FBUSxDQUFDLFdBQVo7QUFDRSxNQUFBLEtBQUEsR0FBUSxDQUFBLENBQUUseUJBQUYsQ0FBNEIsQ0FBQyxJQUE3QixDQUFrQyxTQUFsQyxDQUFSLENBQUE7QUFDQSxNQUFBLElBQUcsS0FBSDtlQUNFLEdBQUcsQ0FBQyxnQkFBSixDQUFxQixjQUFyQixFQUFxQyxLQUFyQyxFQURGO09BRkY7S0FEZTtFQUFBLENBQWpCLENBQUEsQ0FBQTtTQU1BLENBQUMsQ0FBQyxFQUFFLENBQUMsR0FBRyxDQUFDLFFBQVEsQ0FBQyxHQUFsQixHQUF3QjtBQUFBLElBQ3RCLGdCQUFBLEVBQWtCLG1CQURJO0FBQUEsSUFFdEIsZ0JBQUEsRUFBa0IsMkJBRkk7SUFQeEI7QUFBQSxDQUFGLENBQUEsQ0FBQSIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt0aHJvdyBuZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpfXZhciBmPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChmLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGYsZi5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiLCIkIC0+XG4gICQuYWpheFByZWZpbHRlciggKG9wdGlvbnMsIG9yaWdpbmFsT3B0aW9ucywgeGhyKSAtPlxuICAgIGlmICFvcHRpb25zLmNyb3NzRG9tYWluXG4gICAgICB0b2tlbiA9ICQoJ21ldGFbbmFtZT1cImNzcmYtdG9rZW5cIl0nKS5hdHRyICdjb250ZW50J1xuICAgICAgaWYgdG9rZW5cbiAgICAgICAgeGhyLnNldFJlcXVlc3RIZWFkZXIgJ1gtQ1NSRi1Ub2tlbicsIHRva2VuXG4gIClcbiAgJC5mbi5hcGkuc2V0dGluZ3MuYXBpID0ge1xuICAgICd1cGRhdGUgZmVlbGluZyc6ICcvYXBpL2ZlZWxpbmcve2F0fScsXG4gICAgJ3VwZGF0ZSBjb21tZW50JzogJy9hcGkvZmVlbGluZy97aWR9L2NvbW1lbnQnLFxuICB9XG4iXX0=
