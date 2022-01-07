const fs = require('fs-extra');

const generate_js = async () => {
  console.log(`\n Generating web-vitals.js`);

  console.log(`\n Checking node`);
  await fs.pathExists('./node_modules/web-vitals/dist/web-vitals.umd.js', (err, exists) => {
    console.log(err) // => null
    console.log(exists) // => false
  })

  console.log(`\n Copying web-vitals.js`);
  await fs.copy(
    './node_modules/web-vitals/dist/web-vitals.umd.js',
    './static/js/web-vitals.js',
  );

  console.log(`\n Checking web-vitals.js`);
  await fs.pathExists('./static/js/web-vitals.js', (err, exists) => {
    console.log(err) // => null
    console.log(exists) // => false
  })
};

module.exports = {
  generate_js,
};
