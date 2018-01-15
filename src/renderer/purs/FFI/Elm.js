'use strict';

const Elm = require('../../elm/Main');

// Start the elm app in the container
// pass it the initial flag
// and keep a reference for communicating with the app
exports._startElmImpl = function(flag) {
  return function() {
    return Elm.Main.fullscreen(flag);
  };
};
