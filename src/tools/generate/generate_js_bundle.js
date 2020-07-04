const browserify = require('browserify');
const fs = require('fs-extra');

const generate_js_bundle = async () => {
  browserify(['./tools/generate/web-vitals.js'])
    .transform('babelify', {
      presets: ['@babel/preset-env'],
    })
    .bundle()
    .pipe(fs.createWriteStream('./static/js/bundle.js'));
};

(async () => {
  await generate_js_bundle();
})();