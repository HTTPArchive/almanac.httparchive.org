let { generate_last_updated } = require('./generate_last_updated');
let { generate_chapters } = require('./generate_chapters');

(async () => {
  // TODO: Only regenerate for changed contents.
  //await generate_last_updated();

  // TODO: Generate visualisations
  await generate_chapters();
})();
