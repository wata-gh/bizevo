gulp = require 'gulp'
coffee = require 'gulp-coffee'

(require 'require-dir') './gulp'

gulp.task 'default', ['clean'], ->
    gulp.start 'build'
