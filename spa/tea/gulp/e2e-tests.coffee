gulp = require 'gulp'

$ = require('gulp-load-plugins')()

browserSync = require 'browser-sync'

# Downloads the selenium webdriver
gulp.task 'webdriver-update', $.protractor.webdriver_update

gulp.task 'webdriver-standalone', $.protractor.webdriver_standalone

gulp.task 'protractor-only', ['webdriver-update', 'wiredep'], (done) ->
  testFiles = ['test/e2e/**/*.js']

  gulp.src testFiles
    .pipe $.protractor.protractor(
      configFile: 'test/protractor.conf.js'
    )
    .on 'error', (err) ->
      # Make sure failed tests cause gulp to exit non-zero
      throw err
    .on 'end', ->
      # Close browser sync server
      browserSync.exit()
      done()

gulp.task 'protractor', ['serve:e2e', 'protractor-only']
gulp.task 'protractor:src', ['serve:e2e', 'protractor-only']
gulp.task 'protractor:dist', ['serve:e2e-dist', 'protractor-only']
