'use strict';

module.exports = {
  pursRule: {
    test: /\.purs$/,
    loader: 'purs-loader',
    exclude: [/node_modules/],
    query: {
      src: ['bower_components/purescript-*/src/**/*.purs', 'src/**/*.purs']
    }
  }
};
