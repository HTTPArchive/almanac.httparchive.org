let { generate_chapters } = require('./generate_chapters');

(async () => {
  // Can uncomment this to get latest timestamps from origin:main
  // let { generate_last_updated } = require('./generate_last_updated');
  // await generate_last_updated();

  await generate_chapters();
})();
