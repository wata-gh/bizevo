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
  $.fn.api.settings.api = {
    'update feeling': '/api/feeling/{at}',
    'update comment': '/api/feeling/{id}/comment'
  };
  $('.message .close').on('click', function() {
    return $(this).closest('.message').fadeOut();
  });
  return $('.ui.dropdown').dropdown();
});



},{}]},{},[1])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9ob21lL3dlYnNlcnZpY2UvcHJvamVjdHMvYml6ZXZvL25vZGVfbW9kdWxlcy9ndWxwLWJyb3dzZXJpZnkvbm9kZV9tb2R1bGVzL2Jyb3dzZXJpZnkvbm9kZV9tb2R1bGVzL2Jyb3dzZXItcGFjay9fcHJlbHVkZS5qcyIsIi9ob21lL3dlYnNlcnZpY2UvcHJvamVjdHMvYml6ZXZvL2Fzc2V0cy9qYXZhc2NyaXB0cy9hcHAuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUEsQ0FBQSxDQUFFLFNBQUEsR0FBQTtBQUNBLEVBQUEsQ0FBQyxDQUFDLGFBQUYsQ0FBaUIsU0FBQyxPQUFELEVBQVUsZUFBVixFQUEyQixHQUEzQixHQUFBO0FBQ2YsUUFBQSxLQUFBO0FBQUEsSUFBQSxJQUFHLENBQUEsT0FBUSxDQUFDLFdBQVo7QUFDRSxNQUFBLEtBQUEsR0FBUSxDQUFBLENBQUUseUJBQUYsQ0FBNEIsQ0FBQyxJQUE3QixDQUFrQyxTQUFsQyxDQUFSLENBQUE7QUFDQSxNQUFBLElBQUcsS0FBSDtlQUNFLEdBQUcsQ0FBQyxnQkFBSixDQUFxQixjQUFyQixFQUFxQyxLQUFyQyxFQURGO09BRkY7S0FEZTtFQUFBLENBQWpCLENBQUEsQ0FBQTtBQUFBLEVBTUEsQ0FBQyxDQUFDLEVBQUUsQ0FBQyxHQUFHLENBQUMsUUFBUSxDQUFDLEdBQWxCLEdBQXdCO0FBQUEsSUFDdEIsZ0JBQUEsRUFBa0IsbUJBREk7QUFBQSxJQUV0QixnQkFBQSxFQUFrQiwyQkFGSTtHQU54QixDQUFBO0FBQUEsRUFVQSxDQUFBLENBQUUsaUJBQUYsQ0FDQSxDQUFDLEVBREQsQ0FDSSxPQURKLEVBQ2EsU0FBQSxHQUFBO1dBQ1gsQ0FBQSxDQUFFLElBQUYsQ0FDQSxDQUFDLE9BREQsQ0FDUyxVQURULENBRUEsQ0FBQyxPQUZELENBQUEsRUFEVztFQUFBLENBRGIsQ0FWQSxDQUFBO1NBZUEsQ0FBQSxDQUFFLGNBQUYsQ0FDQSxDQUFDLFFBREQsQ0FBQSxFQWhCQTtBQUFBLENBQUYsQ0FBQSxDQUFBIiwiZmlsZSI6ImdlbmVyYXRlZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzQ29udGVudCI6WyIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3Rocm93IG5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIil9dmFyIGY9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGYuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sZixmLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSIsIiQgLT5cbiAgJC5hamF4UHJlZmlsdGVyKCAob3B0aW9ucywgb3JpZ2luYWxPcHRpb25zLCB4aHIpIC0+XG4gICAgaWYgIW9wdGlvbnMuY3Jvc3NEb21haW5cbiAgICAgIHRva2VuID0gJCgnbWV0YVtuYW1lPVwiY3NyZi10b2tlblwiXScpLmF0dHIgJ2NvbnRlbnQnXG4gICAgICBpZiB0b2tlblxuICAgICAgICB4aHIuc2V0UmVxdWVzdEhlYWRlciAnWC1DU1JGLVRva2VuJywgdG9rZW5cbiAgKVxuICAkLmZuLmFwaS5zZXR0aW5ncy5hcGkgPSB7XG4gICAgJ3VwZGF0ZSBmZWVsaW5nJzogJy9hcGkvZmVlbGluZy97YXR9JyxcbiAgICAndXBkYXRlIGNvbW1lbnQnOiAnL2FwaS9mZWVsaW5nL3tpZH0vY29tbWVudCcsXG4gIH1cbiAgJCAnLm1lc3NhZ2UgLmNsb3NlJ1xuICAub24gJ2NsaWNrJywgLT5cbiAgICAkIHRoaXNcbiAgICAuY2xvc2VzdCAnLm1lc3NhZ2UnXG4gICAgLmZhZGVPdXQoKVxuICAkICcudWkuZHJvcGRvd24nXG4gIC5kcm9wZG93bigpXG5cbiJdfQ==
