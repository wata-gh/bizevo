gulp = require 'gulp'

browserSync = require 'browser-sync'

middleware = require './proxy'

browserSyncInit = (baseDir, files, browser) ->
  browser = 'default' if browser is undefined

  browserSync.instance = browserSync.init(files,{
    startPath: '/index.html',
    server:
      baseDir: baseDir,
      middleware: middleware,
    ,
    browser: browser,
  })

gulp.task 'serve', ['watch'], ->
  browserSyncInit [
    'src',
    '.tmp',
  ], [
    '.tmp/{app,components}/**/*.css',
    'src/assets/images/**/*',
    'src/*.html',
    'src/{app,components}/**/*.html',
    'src/{app,components}/**/*.js',
  ]

gulp.task 'serve:dist', ['build'], ->
  browserSyncInit 'dist'

gulp.task 'serve:e2e', ->
  browserSyncInit ['src', '.tmp'], null, []

gulp.task 'serve:e2e-dist', ['watch'], ->
  browserSyncInit 'dist', null, []
