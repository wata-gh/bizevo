(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
$(function() {
  return $.ajaxPrefilter(function(options, originalOptions, xhr) {
    var token;
    if (!options.crossDomain) {
      token = $('meta[name="csrf-token"]').attr('content');
      if (token) {
        return xhr.setRequestHeader('X-CSRF-Token', token);
      }
    }
  });
});



},{}]},{},[1])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9ob21lL3dlYnNlcnZpY2UvcHJvamVjdHMvYml6ZXZvL25vZGVfbW9kdWxlcy9ndWxwLWJyb3dzZXJpZnkvbm9kZV9tb2R1bGVzL2Jyb3dzZXJpZnkvbm9kZV9tb2R1bGVzL2Jyb3dzZXItcGFjay9fcHJlbHVkZS5qcyIsIi9ob21lL3dlYnNlcnZpY2UvcHJvamVjdHMvYml6ZXZvL2Fzc2V0cy9qYXZhc2NyaXB0cy9hcHAuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUEsQ0FBQSxDQUFFLFNBQUEsR0FBQTtTQUNBLENBQUMsQ0FBQyxhQUFGLENBQWlCLFNBQUMsT0FBRCxFQUFVLGVBQVYsRUFBMkIsR0FBM0IsR0FBQTtBQUNmLFFBQUEsS0FBQTtBQUFBLElBQUEsSUFBRyxDQUFBLE9BQVEsQ0FBQyxXQUFaO0FBQ0UsTUFBQSxLQUFBLEdBQVEsQ0FBQSxDQUFFLHlCQUFGLENBQTRCLENBQUMsSUFBN0IsQ0FBa0MsU0FBbEMsQ0FBUixDQUFBO0FBQ0EsTUFBQSxJQUFHLEtBQUg7ZUFDRSxHQUFHLENBQUMsZ0JBQUosQ0FBcUIsY0FBckIsRUFBcUMsS0FBckMsRUFERjtPQUZGO0tBRGU7RUFBQSxDQUFqQixFQURBO0FBQUEsQ0FBRixDQUFBLENBQUEiLCJmaWxlIjoiZ2VuZXJhdGVkLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXNDb250ZW50IjpbIihmdW5jdGlvbiBlKHQsbixyKXtmdW5jdGlvbiBzKG8sdSl7aWYoIW5bb10pe2lmKCF0W29dKXt2YXIgYT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2lmKCF1JiZhKXJldHVybiBhKG8sITApO2lmKGkpcmV0dXJuIGkobywhMCk7dGhyb3cgbmV3IEVycm9yKFwiQ2Fubm90IGZpbmQgbW9kdWxlICdcIitvK1wiJ1wiKX12YXIgZj1uW29dPXtleHBvcnRzOnt9fTt0W29dWzBdLmNhbGwoZi5leHBvcnRzLGZ1bmN0aW9uKGUpe3ZhciBuPXRbb11bMV1bZV07cmV0dXJuIHMobj9uOmUpfSxmLGYuZXhwb3J0cyxlLHQsbixyKX1yZXR1cm4gbltvXS5leHBvcnRzfXZhciBpPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7Zm9yKHZhciBvPTA7bzxyLmxlbmd0aDtvKyspcyhyW29dKTtyZXR1cm4gc30pIiwiJCAtPlxuICAkLmFqYXhQcmVmaWx0ZXIoIChvcHRpb25zLCBvcmlnaW5hbE9wdGlvbnMsIHhocikgLT5cbiAgICBpZiAhb3B0aW9ucy5jcm9zc0RvbWFpblxuICAgICAgdG9rZW4gPSAkKCdtZXRhW25hbWU9XCJjc3JmLXRva2VuXCJdJykuYXR0ciAnY29udGVudCdcbiAgICAgIGlmIHRva2VuXG4gICAgICAgIHhoci5zZXRSZXF1ZXN0SGVhZGVyICdYLUNTUkYtVG9rZW4nLCB0b2tlblxuICApIl19
