const fs = require('fs-extra');
const { execSync } = require('child_process');
const { find_files } = require('./shared');

const generate_last_updated = async () => {
  for (const file of await find_files()) {
    console.log(`\n Setting the last_updated field on ${file}`);

    // Fetch the last modified date, according to the git log.
    const date = get_last_updated_date(file);
    console.log(`  last_updated: ${date}`);

    // Read the content of the file
    let content = await fs.readFile(file, 'utf-8');

    // Replace the frontmatter last_updated field. This is not
    // greedy, so it will match the first instance (which must be
    // in the frontmatter).
    content = content.replace(/last_updated:\s*(\S*)/, `last_updated: ${date}`);

    // Overwrite the file with the updated date.
    await fs.outputFile(file, content, 'utf8');
  }
};

const get_last_updated_date = (path) => {
  const command = `git log -1 --date=iso-strict-local ${path} | cat`;
  const stdout = execSync(command).toString();
  const date_string = /Date:\s+(\S*)/g.exec(stdout)[1];
  const date = new Date(date_string);

  return date.toUTCString();
};

module.exports = {
  generate_last_updated
};
