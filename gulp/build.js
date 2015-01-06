
var gulp = require('gulp');
var $ = require('gulp-load-plugins')({
  pattern: ['gulp-*' , 'del']
});

var errorHandler = function handleError(err) {
  console.error(err.toString());
  this.emit('end');
};

gulp.task('scripts', function () {
  return gulp.src('app/scripts/**/*.coffee')
    .pipe($.coffeelint())
    .pipe($.coffeelint.reporter())
    .pipe($.coffeeify())
    .on('error', errorHandler)
    .pipe(gulp.dest('.tmp/scripts'));
});

gulp.task('sass', function(){
  return gulp.src('app/styles/*.scss')
    .pipe($.sass())
    .on('error', errorHandler)
    .pipe(gulp.dest('.tmp/styles'));
});

gulp.task('html', function () {
  return gulp.src('app/*.html')
    .pipe(gulp.dest('.tmp/'));
});

gulp.task('manifest', function () {
  return gulp.src('app/manifest.json')
    .pipe(gulp.dest('.tmp/'));
});

gulp.task('locales', function () {
  return gulp.src('app/_locales/**/*')
    .pipe(gulp.dest('.tmp/_locales'));
});

gulp.task('images', function () {
  return gulp.src('app/images/*')
    //minify?
    .pipe(gulp.dest('.tmp/images'));
});

gulp.task('bower', function () {
  return gulp.src('app/bower_components/jquery/dist/jquery.js')
    .pipe(gulp.dest('.tmp/scripts'));
});

gulp.task('dist', function () {
  return gulp.src('.tmp/**/*')
    .pipe(gulp.dest('dist'))
    .pipe($.size());
});

gulp.task('clean', function (cb) {
   $.del([
    'dist',
    '.tmp',
    '.sass-cache'
  ], cb);
});

gulp.task('extension', ['scripts', 'sass', 'html', 'manifest', 'images', 'locales', 'bower']);

gulp.task('build', ['extension', 'dist']);