'use strict';

const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');
const webpack = require('webpack');

const config = require('./webpack.config');

let mainWindow;

app.on('ready', createWindow);

webpack(config).watch({}, () => {
  if (mainWindow) {
    mainWindow.reload();
  };
});

function closeWindow() {
  if (mainWindow) {
    mainWindow.close();
  };
}

function minimizeWindow() {
  if (mainWindow) {
    mainWindow.minimize();
  };
}

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 1024,
    height: 768,
    frame: false,
    show: false
  });

  mainWindow.loadURL(path.join('file://', __dirname, 'dist', 'index.html'));

  mainWindow.once('ready-to-show', () => {
    mainWindow.show();
  });

  // open dev tools by default so we can see any console errors
  mainWindow.webContents.openDevTools();

  mainWindow.on('closed', () => {
    mainWindow = null;
  });
}

const CloseWindow = 'CloseWindow';
const MinimizeWindow = 'MinimizeWindow';

ipcMain.on('system-action', (event, action) => {
  switch (action) {
    case CloseWindow:
      closeWindow();
      break;

    case MinimizeWindow:
      minimizeWindow();
      break;
  }
})

/* Mac Specific things */

// When you close all the windows on a non-mac OS it quits the app
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

// If there is no mainWindow it creates one (like when you click the dock icon)
app.on('activate', () => {
  if (mainWindow === null) {
    createWindow();
  }
});
