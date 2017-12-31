'use strict';

const combineLoaders = require('webpack-combine-loaders');
const copyWebpackPlugin = require('copy-webpack-plugin');
const path = require('path');
const webpack = require('webpack');

const HtmlWebpackPlugin = require('html-webpack-plugin');

const prod = process.env.NODE_ENV === 'production';

module.exports = {
  entry: './src/index.js',
  output: {
    path: path.join(__dirname, 'dist'),
    filename: 'bundle.js'
  },
  watch: true,
  target: 'electron',
  devtool: prod && 'source-map' || 'inline-source-map',
  module: {
    loaders: [{
      test:    /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      loader: combineLoaders([{
        loader: 'elm-hot-loader'
      }, {
        loader: 'elm-webpack-loader',
        options: {
          cwd: __dirname,
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
  plugins: [
    new copyWebpackPlugin(['./src/static/']),
    new HtmlWebpackPlugin({
      title: 'Dominus',
      hash: true,
      filename: './index.html'
    }),
    new webpack.NamedModulesPlugin(),
    new webpack.HotModuleReplacementPlugin()
  ],
  resolve: {
    extensions: ['.js', '.elm', '.purs']
  }
};
