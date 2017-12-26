'use strict';

exports._startPorts = function(outgoingPortHandler) {
  return function(app) {
    return function() {
      app.ports.outOfElm.subscribe(function(action) {
        outgoingPortHandler(action)();
      });
    };
  };
};
