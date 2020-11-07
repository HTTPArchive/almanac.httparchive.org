var watch = require('node-watch');
let { generate_chapters } = require('./generate_chapters');
const { exec } = require("child_process");
 
watch('content', { filter: /\.md$/, recursive: true }, async function(evt, name) {
  console.log('File modified: %s', name);
  if (evt != 'remove') {
    await generate_chapters(name)
  }
});
