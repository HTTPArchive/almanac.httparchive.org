var watch = require('node-watch');
let { generate_chapters } = require('./generate_chapters');
const { exec } = require("child_process");
 
watch('content', { filter: /\.md$/, recursive: true }, async function(evt, name) {
  console.log('File modified: %s', name);
  if (evt != 'remove') {
    await generate_chapters(name)
      /*
      const command = 'npm run generate ' + name;
      exec (command, (err, stdout, stderr) => {
        if (err) {
          // some err occurred
          console.error(err)
        } else {
          // the *entire* stdout and stderr (buffered)
          console.log(`stdout: ${stdout}`);
          console.log(`stderr: ${stderr}`);
        }
      });
      */
  }
});
