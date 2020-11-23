let { test_status_codes } = require('./test_status_codes');

(async () => {
  try {
    await test_status_codes();
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
})();
