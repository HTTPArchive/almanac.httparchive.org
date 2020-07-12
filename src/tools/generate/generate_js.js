const fs = require('fs-extra');

const generate_js = async () => {
  fs.copy(
    './node_modules/web-vitals/dist/web-vitals.es5.umd.min.js',
    './static/js/web-vitals.js',
  ).catch(err => console.error(err));
};

module.exports = {
  generate_js,
};
