# How to run
# gulp --gulpfile=gulpfile_tea.coffee Task
gulp       = require 'gulp'
rename     = require 'gulp-rename'
gutil      = require 'gulp-util'
rimraf     = require 'gulp-rimraf'
size       = require 'gulp-size'

gulp.task 'clean', ->
  gulp.src ['public/tea/{scripts,styles,fonts}/**/*', 'app/views/tea/**/*.erb'], read: false
    .pipe rimraf()
    .pipe size()

gulp.task 'deploy', ->
  fs = require 'fs'
  fs.exists 'spa/tea/dist', (exists) ->
    unless exists
      gutil.log gutil.colors.red('TeaParty build first!!')
      return
    gulp.start ['clean', 'deploy:erb', 'deploy:assets']

gulp.task 'deploy:erb', ->
  gulp.src 'spa/tea/dist/*.html'
    .pipe rename (path) ->
      path.extname = '.erb'
    .pipe gulp.dest('app/views/tea/')
    .pipe size()

gulp.task 'deploy:assets', ->
  gulp.src 'spa/tea/dist/{fonts,scripts,styles}/**/*'
    .pipe gulp.dest('public/tea/')
    .pipe size()

gulp.task 'default', ['deploy']
