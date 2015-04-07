gulp = require 'gulp'

$ = require('gulp-load-plugins')()

wiredep = require 'wiredep'

gulp.task 'test', ->
  bowerDeps = wiredep
    directory: 'src/bower_components',
    exclude: ['bootstrap-sass-official'],
    dependencies: true,
    devDependencies: true

  testFiles = bowerDeps.js.concat ['src/{app,components}/**/*.js', 'test/unit/**/*.js']

  gulp.src testFiles
    .pipe $.karma configFile: 'test/karma.conf.js', action: 'run'
    .on 'error', (err) ->
      # Make sure failed tests cause gulp to exit non-zero
      throw err
