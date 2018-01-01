'use strict';

const combineLoaders = require('webpack-combine-loaders');

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
    }, {
      test: /\.purs$/,
      loader: 'purs-loader',
      exclude: [/node_modules/],
      query: {
        src: ['bower_components/purescript-*/src/**/*.purs', 'src/**/*.purs']
      }
    }]
  },
  resolve: {
    extensions: ['.js', '.elm', '.purs']
  }
};
