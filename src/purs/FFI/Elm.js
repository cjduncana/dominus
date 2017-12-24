'use strict';

const Elm = require('../../elm/Main');

// Start the elm app in the container
// pass it the initial flags
// and keep a reference for communicating with the app
exports.startElmImpl = function(flags) {
  return function() {
    Elm.Main.fullscreen(flags);
  };
};
