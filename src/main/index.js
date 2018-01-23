'use strict';

const isDevelopment = process.env.NODE_ENV !== 'production';

const url = isDevelopment
  ? `http://localhost:${process.env.ELECTRON_WEBPACK_WDS_PORT}`
  : `file://${__dirname}/index.html`;

require('./Main').main(url)(isDevelopment)();
