gulp = require 'gulp'
bower = require 'gulp-bower'

gulp.task 'bower', ->
  bower cmd: 'update'
