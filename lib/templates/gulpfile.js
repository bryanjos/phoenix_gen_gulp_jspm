"use strict";

var gulp = require("gulp");
var babel = require("gulp-babel");
var cssnext = require("gulp-cssnext");
var concat = require("gulp-concat");
var plumber = require("gulp-plumber");

var cssSrc = "web/static/css/*.css";
var cssDest = "priv/static/css";

var jsSrc = "web/static/js/**/*.js*";
var jsDest = "priv/static/js";


function reportChange(event){
  console.log("File " + event.path + " was " + event.type + ", running tasks...");
}

gulp.task("build-css", function() {
  gulp.src(cssSrc)
      .pipe(cssnext({
          compress: true
      }))
      .pipe(gulp.dest(cssDest));
});

gulp.task("build-js", function() {
  return gulp.src(jsSrc)
      .pipe(plumber())
      .pipe(babel({sourceMap: false, modules: "system"}))
      .pipe(gulp.dest(jsDest));
});

gulp.task("build", ["build-js", "build-css"]);


gulp.task("watch", ["build"], function() {
  gulp.watch([jsSrc, cssSrc], ["build"]).on("change", reportChange);
});


gulp.task("default", ["build"]);