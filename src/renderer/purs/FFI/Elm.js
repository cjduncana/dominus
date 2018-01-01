'use strict';

const Elm = require('../../elm/Main');

// Start the elm app in the container
// pass it the initial flags
// and keep a reference for communicating with the app
exports._startElmImpl = function(flags) {
  return function() {
    return Elm.Main.fullscreen(flags);
  };
};
