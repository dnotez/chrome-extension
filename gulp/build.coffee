gulp = require 'gulp'

$ = do (r = require 'gulp-load-plugins') ->
  r {pattern:['gulp-*', 'del']}

errorHandler = (err) ->
  console.log err.toString()
  this.emit 'end'
  return

gulp.task 'scripts', ->
  gulp.src 'app/scripts/**/*.coffee'
  .pipe $.coffeelint()
  .pipe $.coffeelint.reporter()
  .pipe $.coffeeify()
  .on 'error', errorHandler
  .pipe gulp.dest '.tmp/scripts'

gulp.task 'sass', ->
  gulp.src 'app/styles/**/*.scss'
  .pipe $.sass()
  .on 'error', errorHandler
  .pipe gulp.dest '.tmp/styles'

gulp.task 'html', ->
  gulp.src 'app/*.html'
  .pipe gulp.dest '.tmp'

gulp.task 'manifest', ->
  gulp.src 'app/manifest.json'
  .pipe gulp.dest '.tmp'

gulp.task 'images', ->
  gulp.src 'app/images/**/*'
  .pipe gulp.dest '.tmp/images'

gulp.task 'locales', ->
  gulp.src 'app/_locales/**/*'
  .pipe gulp.dest '.tmp/_locales'

gulp.task 'bower', ->
  gulp.src 'app/bower_components/jquery/dist/jquery.js'
  .pipe gulp.dest '.tmp/scripts'

gulp.task 'dist', ['make-extension'], ->
  gulp.src '.tmp/**/*'
  .pipe gulp.dest 'dist'
  .pipe $.size()

gulp.task 'clean', (cb) ->
  $.del(['dist', '.tmp', '.sass-cache'], cb)
  return

gulp.task 'make-extension', ['scripts', 'sass', 'html', 'manifest', 'images', 'locales', 'bower']
gulp.task 'build', ['dist']