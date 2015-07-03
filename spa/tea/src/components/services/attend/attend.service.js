'use strict';

angular.module('tea')
  .factory('attendService', function (Attend) {
    return {
      attendParty: function(party) {
        var attend = new Attend({id: party.id});
        var callback = function(attends) {
          party.attends = attends;
        };
        return party.attends.isAttended ? attend.$delete(callback) : attend.$save(callback);
      }
    };
  });