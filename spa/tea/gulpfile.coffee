gulp = require 'gulp'
coffee = require 'gulp-coffee'

gulp = require 'gulp'

(require 'require-dir') './gulp'

gulp.task 'default', ['clean'], ->
    gulp.start 'build'
