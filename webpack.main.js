'use strict';

const common = require('./webpack.common');

module.exports = {
  module: {
    rules: [common.pursRule]
  },
  resolve: {
    extensions: ['.js', '.purs']
  }
};
