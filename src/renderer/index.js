'use strict';

const { app } = require('electron').remote;

const userDataPath = app.getPath('userData');

require('./purs/Renderer').main(userDataPath)();
