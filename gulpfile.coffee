gulp       = require 'gulp'
rename     = require 'gulp-rename'
plumber    = require 'gulp-plumber'
concat     = require 'gulp-concat'
sass       = require 'gulp-sass'
bowerFiles = require 'main-bower-files'
source     = require 'vinyl-source-stream'
browserify = require 'gulp-browserify'
bower      = require 'gulp-bower'
gulpFilter = require 'gulp-filter'

gulp.task 'js', ->
  gulp
    .src './assets/javascripts/app.coffee', read: false
    .pipe plumber()
    .pipe browserify
      transform: ['coffeeify']
      extensions: ['.coffee']
      debug: true
  .pipe rename 'app.js'
  .pipe gulp.dest 'public/javascripts'
  gulp
  .src './assets/javascripts/feeling/app.coffee', read: false
  .pipe plumber()
  .pipe browserify
    transform: ['coffeeify']
    extensions: ['.coffee']
    debug: true
  .pipe rename 'feeling.js'
  .pipe gulp.dest 'public/javascripts'
  gulp
  .src './assets/javascripts/feeling/detail/app.coffee', read: false
  .pipe plumber()
  .pipe browserify
    transform: ['coffeeify']
    extensions: ['.coffee']
    debug: true
  .pipe rename 'feeling_detail.js'
  .pipe gulp.dest 'public/javascripts'

gulp.task 'vendor', ->
  jsFilter = gulpFilter '**/*.js'
  cssFilter = gulpFilter '**/*.css'
  gulp.src(bowerFiles())
  .pipe jsFilter
  .pipe plumber()
  .pipe concat('vendor.js')
  .pipe gulp.dest('./public/javascripts')
  gulp.src(bowerFiles())
  .pipe cssFilter
  .pipe plumber()
  .pipe concat('vendor.css')
  .pipe gulp.dest('./public/stylesheets')

gulp.task 'css', ->
  gulp
  .src './app/styles/*.scss'
  .pipe plumber()
  .pipe sass()
  .pipe gulp.dest './public/stylesheets'
  gulp
  .src 'bower_components/semantic/dist/themes/**/*'
  .pipe gulp.dest './public/stylesheets/themes'

gulp.task 'watch', ['build'], ->
  gulp.watch 'assets/**/*.coffee', ['js']
  gulp.watch 'app/**/*.jade', ['js']
  gulp.watch 'app/styles/**/*.scss', ['css']
  gulp.watch 'bower_components/**/*.js', ['vendor']

gulp.task 'bower', ->
  bower {cmd: 'update'}
gulp.task 'build', ['vendor', 'js', 'css']
gulp.task 'default', ['build']
