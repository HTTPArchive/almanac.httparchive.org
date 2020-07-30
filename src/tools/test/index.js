let { test_status_codes } = require('./test_status_codes');

(async () => {
  // Can uncomment this to get latest timestamps from origin:main
  // let { generate_last_updated } = require('./generate_last_updated');
  // await generate_last_updated();

  await test_status_codes();
})();
