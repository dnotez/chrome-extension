gulp = require 'gulp'
phantom = require 'gulp-phantom'

gulp.task 'test', ['scripts'], ->
  gulp.src 'test/extension/run.js'
  .pipe phantom()
  .pipe gulp.dest 'build'