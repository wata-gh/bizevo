gulp = require 'gulp'

browserSync = require 'browser-sync'

middleware = require './proxy'

apimock = (req, res, next) ->
  url = req.url.toString()
  method = req.method.toString()

  res.setHeader("Content-Type", "application/json") if /^\/api\/.+/.test url
  req.url = "#{url}_#{method}" if /^\/api\/.+/.test url && method != 'get'
  next()

if middleware?
  middleware = apimock
else if !(middleware.unshift?(apimock))
  middleware = [middleware, apimock]

browserSyncInit = (baseDir, files, browser) ->
  browser = 'default' if browser is undefined

  browserSync.instance = browserSync.init(files,{
    startPath: '/index.html',
    server:
      baseDir: baseDir,
      middleware: middleware
    ,
    browser: browser,
  })

gulp.task 'serve', ['inject', 'watch'], ->
  browserSyncInit [
    'src',
    '.tmp',
    'mocks',
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
