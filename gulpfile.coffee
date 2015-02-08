gulp = require 'gulp'

do (r = require 'require-dir') ->
  r './gulp'

gulp.task 'default', ['clean'], ->
  gulp.start 'build'