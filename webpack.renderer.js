'use strict';

const combineLoaders = require('webpack-combine-loaders');

const common = require('./webpack.common');

module.exports = {
  module: {
    rules: [{
      test:    /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      loader: combineLoaders([{
        loader: 'elm-hot-loader'
      }, {
        loader: 'elm-webpack-loader',
        options: {
          forceWatch: true,
          verbose: true,
          warn: true
        }
      }])
    }, common.pursRule]
  },
  resolve: {
    extensions: ['.js', '.elm', '.purs']
  }
};
