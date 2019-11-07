let { generate_last_updated } = require('./generate_last_updated');
let { generate_chapters } = require('./generate_chapters');

(async () => {
  await generate_last_updated();

  // TODO: Generate visualisations
  await generate_chapters();
})();
