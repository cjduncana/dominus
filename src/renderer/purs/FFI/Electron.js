'use strict';

const electron = require('electron');

exports._sendAction = function(action) {
  return function() {
    electron.ipcRenderer.send('system-action', action);
  };
};
