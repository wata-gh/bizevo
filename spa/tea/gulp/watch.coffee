gulp = require 'gulp'

gulp.task 'watch', ['wiredep', 'styles'] , ->
  gulp.watch 'src/{app,components}/**/*.scss', ['styles']
  gulp.watch 'src/{app,components}/**/*.js', ['inject','scripts']
  gulp.watch 'src/assets/images/**/*', ['images']
  gulp.watch 'bower.json', ['wiredep']
