(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
$(function() {
  var bind, eid, init, lid, loading, more, tmpls;
  tmpls = null;
  eid = null;
  lid = null;
  bind = function() {
    var ele, eles, n, par, params, v, _i, _len;
    params = window.location.search.substring(1).split('&');
    par = {
      id: eid
    };
    for (_i = 0, _len = params.length; _i < _len; _i++) {
      eles = params[_i];
      ele = eles.split('=');
      n = decodeURIComponent(ele[0]);
      v = decodeURIComponent(ele[1]);
      par[n] = v;
    }
    return $.get('/api/feeling/bind', par).success(function(r) {
      $('#feelings').prepend(tmpls(r));
      if (r.results.length) {
        eid = r.results[0].id;
        if (lid === null) {
          return lid = r.results[r.results.length - 1].id;
        }
      }
    }).done(function() {
      return setTimeout(bind, 10000);
    });
  };
  loading = 0;
  more = function() {
    var par;
    console.debug('more!');
    if (loading) {
      return;
    }
    par = {
      last_id: lid
    };
    loading = 1;
    return $.get('/api/feeling/more', par).success(function(r) {
      $('#feelings').append(tmpls(r));
      if (r.results.length) {
        return lid = r.results[r.results.length - 1].id;
      }
    }).done(function() {
      return loading = 0;
    });
  };
  init = function() {
    setTimeout(bind, 0);
    return $(window).bottom({
      proximity: 0.05
    }).on('bottom', more);
  };
  return $.ajax('/javascripts/views/feelings.html').success(function(r) {
    tmpls = Handlebars.compile(r);
    return init();
  });
});



},{}]},{},[1])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi9ob21lL3dlYnNlcnZpY2UvcHJvamVjdHMvYml6ZXZvL25vZGVfbW9kdWxlcy9ndWxwLWJyb3dzZXJpZnkvbm9kZV9tb2R1bGVzL2Jyb3dzZXJpZnkvbm9kZV9tb2R1bGVzL2Jyb3dzZXItcGFjay9fcHJlbHVkZS5qcyIsIi9ob21lL3dlYnNlcnZpY2UvcHJvamVjdHMvYml6ZXZvL2Fzc2V0cy9qYXZhc2NyaXB0cy9mZWVsaW5nL2FwcC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUNBQSxDQUFBLENBQUUsU0FBQSxHQUFBO0FBQ0EsTUFBQSwwQ0FBQTtBQUFBLEVBQUEsS0FBQSxHQUFRLElBQVIsQ0FBQTtBQUFBLEVBQ0EsR0FBQSxHQUFNLElBRE4sQ0FBQTtBQUFBLEVBRUEsR0FBQSxHQUFNLElBRk4sQ0FBQTtBQUFBLEVBR0EsSUFBQSxHQUFPLFNBQUEsR0FBQTtBQUNMLFFBQUEsc0NBQUE7QUFBQSxJQUFBLE1BQUEsR0FBUyxNQUNULENBQUMsUUFDRCxDQUFDLE1BQ0QsQ0FBQyxTQUhRLENBR0UsQ0FIRixDQUlULENBQUMsS0FKUSxDQUlGLEdBSkUsQ0FBVCxDQUFBO0FBQUEsSUFNQSxHQUFBLEdBQU07QUFBQSxNQUNKLEVBQUEsRUFBSSxHQURBO0tBTk4sQ0FBQTtBQVNBLFNBQUEsNkNBQUE7d0JBQUE7QUFDRSxNQUFBLEdBQUEsR0FBTSxJQUFJLENBQUMsS0FBTCxDQUFXLEdBQVgsQ0FBTixDQUFBO0FBQUEsTUFDQSxDQUFBLEdBQUksa0JBQUEsQ0FBbUIsR0FBSSxDQUFBLENBQUEsQ0FBdkIsQ0FESixDQUFBO0FBQUEsTUFFQSxDQUFBLEdBQUksa0JBQUEsQ0FBbUIsR0FBSSxDQUFBLENBQUEsQ0FBdkIsQ0FGSixDQUFBO0FBQUEsTUFHQSxHQUFJLENBQUEsQ0FBQSxDQUFKLEdBQVMsQ0FIVCxDQURGO0FBQUEsS0FUQTtXQWNBLENBQUMsQ0FBQyxHQUFGLENBQU0sbUJBQU4sRUFBMkIsR0FBM0IsQ0FDQSxDQUFDLE9BREQsQ0FDUyxTQUFDLENBQUQsR0FBQTtBQUNQLE1BQUEsQ0FBQSxDQUFFLFdBQUYsQ0FDQSxDQUFDLE9BREQsQ0FDUyxLQUFBLENBQU0sQ0FBTixDQURULENBQUEsQ0FBQTtBQUVBLE1BQUEsSUFBRyxDQUFDLENBQUMsT0FBTyxDQUFDLE1BQWI7QUFDRSxRQUFBLEdBQUEsR0FBTSxDQUFDLENBQUMsT0FBUSxDQUFBLENBQUEsQ0FBRSxDQUFDLEVBQW5CLENBQUE7QUFDQSxRQUFBLElBQUcsR0FBQSxLQUFPLElBQVY7aUJBQ0UsR0FBQSxHQUFNLENBQUMsQ0FBQyxPQUFRLENBQUEsQ0FBQyxDQUFDLE9BQU8sQ0FBQyxNQUFWLEdBQW1CLENBQW5CLENBQXFCLENBQUMsR0FEeEM7U0FGRjtPQUhPO0lBQUEsQ0FEVCxDQVNBLENBQUMsSUFURCxDQVNNLFNBQUEsR0FBQTthQUNKLFVBQUEsQ0FBVyxJQUFYLEVBQWlCLEtBQWpCLEVBREk7SUFBQSxDQVROLEVBZks7RUFBQSxDQUhQLENBQUE7QUFBQSxFQStCQSxPQUFBLEdBQVUsQ0EvQlYsQ0FBQTtBQUFBLEVBZ0NBLElBQUEsR0FBTyxTQUFBLEdBQUE7QUFDTCxRQUFBLEdBQUE7QUFBQSxJQUFBLE9BQU8sQ0FBQyxLQUFSLENBQWMsT0FBZCxDQUFBLENBQUE7QUFDQSxJQUFBLElBQVUsT0FBVjtBQUFBLFlBQUEsQ0FBQTtLQURBO0FBQUEsSUFFQSxHQUFBLEdBQU07QUFBQSxNQUNKLE9BQUEsRUFBUyxHQURMO0tBRk4sQ0FBQTtBQUFBLElBS0EsT0FBQSxHQUFVLENBTFYsQ0FBQTtXQU1BLENBQUMsQ0FBQyxHQUFGLENBQU0sbUJBQU4sRUFBMkIsR0FBM0IsQ0FDQSxDQUFDLE9BREQsQ0FDUyxTQUFDLENBQUQsR0FBQTtBQUNQLE1BQUEsQ0FBQSxDQUFFLFdBQUYsQ0FDQSxDQUFDLE1BREQsQ0FDUSxLQUFBLENBQU0sQ0FBTixDQURSLENBQUEsQ0FBQTtBQUVBLE1BQUEsSUFBNEMsQ0FBQyxDQUFDLE9BQU8sQ0FBQyxNQUF0RDtlQUFBLEdBQUEsR0FBTSxDQUFDLENBQUMsT0FBUSxDQUFBLENBQUMsQ0FBQyxPQUFPLENBQUMsTUFBVixHQUFtQixDQUFuQixDQUFxQixDQUFDLEdBQXRDO09BSE87SUFBQSxDQURULENBTUEsQ0FBQyxJQU5ELENBTU0sU0FBQSxHQUFBO2FBQ0osT0FBQSxHQUFVLEVBRE47SUFBQSxDQU5OLEVBUEs7RUFBQSxDQWhDUCxDQUFBO0FBQUEsRUFnREEsSUFBQSxHQUFPLFNBQUEsR0FBQTtBQUNMLElBQUEsVUFBQSxDQUFXLElBQVgsRUFBaUIsQ0FBakIsQ0FBQSxDQUFBO1dBQ0EsQ0FBQSxDQUFFLE1BQUYsQ0FDQSxDQUFDLE1BREQsQ0FDUTtBQUFBLE1BQUMsU0FBQSxFQUFXLElBQVo7S0FEUixDQUVBLENBQUMsRUFGRCxDQUVJLFFBRkosRUFFYyxJQUZkLEVBRks7RUFBQSxDQWhEUCxDQUFBO1NBdURBLENBQUMsQ0FBQyxJQUFGLENBQU8sa0NBQVAsQ0FDQSxDQUFDLE9BREQsQ0FDUyxTQUFDLENBQUQsR0FBQTtBQUNQLElBQUEsS0FBQSxHQUFRLFVBQVUsQ0FBQyxPQUFYLENBQW1CLENBQW5CLENBQVIsQ0FBQTtXQUNBLElBQUEsQ0FBQSxFQUZPO0VBQUEsQ0FEVCxFQXhEQTtBQUFBLENBQUYsQ0FBQSxDQUFBIiwiZmlsZSI6ImdlbmVyYXRlZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzQ29udGVudCI6WyIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3Rocm93IG5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIil9dmFyIGY9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGYuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sZixmLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSIsIiQgLT5cbiAgdG1wbHMgPSBudWxsXG4gIGVpZCA9IG51bGxcbiAgbGlkID0gbnVsbFxuICBiaW5kID0gLT5cbiAgICBwYXJhbXMgPSB3aW5kb3dcbiAgICAubG9jYXRpb25cbiAgICAuc2VhcmNoXG4gICAgLnN1YnN0cmluZyAxXG4gICAgLnNwbGl0ICcmJ1xuXG4gICAgcGFyID0ge1xuICAgICAgaWQ6IGVpZFxuICAgIH1cbiAgICBmb3IgZWxlcyBpbiBwYXJhbXNcbiAgICAgIGVsZSA9IGVsZXMuc3BsaXQgJz0nXG4gICAgICBuID0gZGVjb2RlVVJJQ29tcG9uZW50IGVsZVswXVxuICAgICAgdiA9IGRlY29kZVVSSUNvbXBvbmVudCBlbGVbMV1cbiAgICAgIHBhcltuXSA9IHZcbiAgICAkLmdldCAnL2FwaS9mZWVsaW5nL2JpbmQnLCBwYXJcbiAgICAuc3VjY2VzcygocikgLT5cbiAgICAgICQgJyNmZWVsaW5ncydcbiAgICAgIC5wcmVwZW5kIHRtcGxzKHIpXG4gICAgICBpZiByLnJlc3VsdHMubGVuZ3RoXG4gICAgICAgIGVpZCA9IHIucmVzdWx0c1swXS5pZFxuICAgICAgICBpZiBsaWQgPT0gbnVsbFxuICAgICAgICAgIGxpZCA9IHIucmVzdWx0c1tyLnJlc3VsdHMubGVuZ3RoIC0gMV0uaWRcbiAgICApXG4gICAgLmRvbmUoLT5cbiAgICAgIHNldFRpbWVvdXQgYmluZCwgMTAwMDBcbiAgICApXG5cbiAgbG9hZGluZyA9IDBcbiAgbW9yZSA9IC0+XG4gICAgY29uc29sZS5kZWJ1ZyAnbW9yZSEnXG4gICAgcmV0dXJuIGlmIGxvYWRpbmdcbiAgICBwYXIgPSB7XG4gICAgICBsYXN0X2lkOiBsaWQsXG4gICAgfVxuICAgIGxvYWRpbmcgPSAxXG4gICAgJC5nZXQgJy9hcGkvZmVlbGluZy9tb3JlJywgcGFyXG4gICAgLnN1Y2Nlc3MoKHIpIC0+XG4gICAgICAkICcjZmVlbGluZ3MnXG4gICAgICAuYXBwZW5kIHRtcGxzKHIpXG4gICAgICBsaWQgPSByLnJlc3VsdHNbci5yZXN1bHRzLmxlbmd0aCAtIDFdLmlkIGlmIHIucmVzdWx0cy5sZW5ndGhcbiAgICApXG4gICAgLmRvbmUgLT5cbiAgICAgIGxvYWRpbmcgPSAwXG5cbiAgaW5pdCA9IC0+XG4gICAgc2V0VGltZW91dCBiaW5kLCAwXG4gICAgJCB3aW5kb3dcbiAgICAuYm90dG9tIHtwcm94aW1pdHk6IDAuMDV9XG4gICAgLm9uKCdib3R0b20nLCBtb3JlKVxuXG5cbiAgJC5hamF4ICcvamF2YXNjcmlwdHMvdmlld3MvZmVlbGluZ3MuaHRtbCdcbiAgLnN1Y2Nlc3MoKHIpIC0+XG4gICAgdG1wbHMgPSBIYW5kbGViYXJzLmNvbXBpbGUgclxuICAgIGluaXQoKVxuICApIl19