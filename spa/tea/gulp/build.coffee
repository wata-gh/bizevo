gulp = require 'gulp'

$ = require('gulp-load-plugins')(
  pattern: ['gulp-*', 'main-bower-files', 'uglify-save-license']
)

handleError = (err) ->
  console.error err.toString()
  this.emit 'end'

gulp.task 'styles', ->
  gulp.src 'src/{app,components}/**/*.scss'
    .pipe $.rubySass(style: 'expanded', bundleExec:true)
    .on 'error', handleError
    .pipe $.autoprefixer('last 1 version')
    .pipe gulp.dest('.tmp')
    .pipe $.size()

gulp.task 'scripts', ->
  gulp.src 'src/{app,components}/**/*.js'
    .pipe $.jshint()
    .pipe $.jshint.reporter('jshint-stylish')
    .pipe $.size()

gulp.task 'partials', ->
  gulp.src 'src/{app,components}/**/*.html'
    .pipe $.minifyHtml
      empty: true,
      spare: true,
      quotes: true
    .pipe $.ngHtml2js
      moduleName: 'tea'
    .pipe gulp.dest('.tmp')
    .pipe $.size()

gulp.task 'inject', ->
  gulp.src 'src/*.html'
    .pipe $.inject(gulp.src('src/{app,components}/**/*.js').pipe($.sort()),
      read: false,
      starttag: '<!-- inject:modules -->',
      addRootSlash: false,
      ignorePath: 'src'
    )
    .pipe gulp.dest('src')
    .pipe $.size()

gulp.task 'html', ['inject', 'styles', 'scripts', 'partials'], ->
  htmlFilter = $.filter '*.html'
  jsFilter = $.filter '**/*.js'
  cssFilter = $.filter '**/*.css'

  gulp.src 'src/*.html'
    .pipe $.inject(gulp.src('.tmp/{app,components}/**/*.js'),
      read: false,
      starttag: '<!-- inject:partials -->',
      addRootSlash: false,
      addPrefix: '../'
    )
    .pipe assets = $.useref.assets()
    .pipe $.rev()
    .pipe jsFilter
    .pipe $.ngAnnotate()
    .pipe $.uglify(preserveComments: $.uglifySaveLicense)
    .pipe jsFilter.restore()
    .pipe cssFilter
    .pipe $.replace('bower_components/bootstrap-sass-official/assets/fonts/bootstrap','fonts')
    .pipe $.csso()
    .pipe cssFilter.restore()
    .pipe assets.restore()
    .pipe $.useref()
    .pipe $.revReplace()
    .pipe htmlFilter
    .pipe $.minifyHtml(
      empty: true,
      spare: true,
      quotes: true,
    )
    .pipe htmlFilter.restore()
    .pipe gulp.dest('dist')
    .pipe $.size()

gulp.task 'images', ->
  gulp.src 'src/assets/images/**/*'
    .pipe $.cache($.imagemin(
      optimizationLevel: 3,
      progressive: true,
      interlaced: true,
    ))
    .pipe gulp.dest('dist/assets/images')
    .pipe $.size()

gulp.task 'fonts', ->
  gulp.src $.mainBowerFiles()
    .pipe $.filter('**/*.{eot,svg,ttf,woff}')
    .pipe $.flatten()
    .pipe gulp.dest('dist/fonts')
    .pipe $.size()

gulp.task 'clean', ->
  gulp.src ['.tmp', 'dist'], read: false
    .pipe $.rimraf()

gulp.task 'build', ['html', 'partials', 'images', 'fonts']
