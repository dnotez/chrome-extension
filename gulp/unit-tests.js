'use strict';

var gulp = require('gulp');
var mochaPhantomJs = require('gulp-mocha-phantomjs');

gulp.task('test', ['scripts'], function () {
  return gulp.src('test/index.html')
    .pipe(mochaPhantomJs({reporter: 'nyan'}));
});