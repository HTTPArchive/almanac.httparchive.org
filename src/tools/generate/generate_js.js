const fs = require('fs-extra');

const generate_js = async () => {
  console.log(`\n Generating web-vitals.js`);
  fs.copy(
    './node_modules/web-vitals/dist/web-vitals.attribution.umd.cjs',
    './static/js/web-vitals.js',
  );
};

module.exports = {
  generate_js,
};
