'use strict';

const SQL = require('sql.js');

exports.close = function(db) {
  return function() {
    return db.close();
  };
};

exports.create = function() {
  return new SQL.Database();
};

exports.exec = function(db) {
  return function(sql) {
    return function() {
      return db.exec(sql);
    };
  };
};

exports.export = function(db) {
  return function() {
    return db.export();
  };
};

exports.open = function(buffer) {
  return function() {
    return new SQL.Database(buffer);
  };
};
