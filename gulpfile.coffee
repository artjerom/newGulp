###
  Author Fred Mello
  1) Dowland (git clone)
  2) npm i --save-dev
  3) Working!
###

gulp    = require 'gulp'
jade    = require 'gulp-jade'
stylus  = require 'gulp-stylus'
connect = require 'gulp-connect'
nib     = require 'nib'
uglify  = require 'gulp-uglify'

gulp.task 'connect', ->
  connect.server
    port: 3000
    livereload: on
    root: './app'

gulp.task 'jade', ->
  gulp.src('source/jade/*.jade')
    .pipe do jade
      # compress: off
    .pipe gulp.dest 'app'
    .pipe do connect.reload

gulp.task 'stylus', ->
  gulp.src('source/stylus/**/*.styl')
    .pipe stylus
      compress: on
      use     : nib()
    .pipe gulp.dest 'app/my_public/'
    .pipe do connect.reload

gulp.task 'js', ->
  gulp.src('source/js/*.js')
    .pipe uglify
      mangle: off
    .pipe gulp.dest 'app/my_public/'
    .pipe do connect.reload

gulp.task 'watch', ->
  gulp.watch 'source/jade/**/*.jade',   ['jade']
  gulp.watch 'source/stylus/**/*.styl', ['stylus']
  gulp.watch 'source/js/**/*.js',       ['js']

gulp.task 'default', ['watch', 'stylus', 'js', 'jade', 'connect']