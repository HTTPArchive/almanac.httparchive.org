const fs = require('fs-extra');
const { execSync } = require('child_process');
const { find_files } = require('./shared');

const generate_last_updated = async () => {
  const command = `git config --get remote.origin.url | cat`;
  const stdout = execSync(command).toString();
  const remoteOrigin = stdout.substr(0, stdout.length - 1);

  // Only execute this if working on the main repo and not a fork
  console.log(":"+remoteOrigin+":");
  if (remoteOrigin !== "git@github.com:HTTPArchive/almanac.httparchive.org.git") {
    console.log('Working on clone. Not updating timestamps.')
    return
  }

  for (const file of await find_files()) {
    console.log(`\n Setting the last_updated field on ${file}`);

    // Fetch the last modified date, according to the git log.
    const date = get_last_updated_date(file);
    console.log(`  last_updated: ${date}:`);

    // Read the content of the file
    let content = await fs.readFile(file, 'utf-8');

    // Replace the frontmatter last_updated field. This is not
    // greedy, so it will match the first instance (which must be
    // in the frontmatter).
    //content = content.replace(/last_updated: [0-9:TZ-]*.*$/, `last_updated: ${date}`);
    content = content.replace(/last_updated:\s*(\S*) */, `last_updated: ${date}`);

    // Overwrite the file with the updated date.
    await fs.outputFile(file, content, 'utf8');
  }
};

const get_last_updated_date = (path) => {
  const command = `git log origin/master -1 --date=iso-strict-local ${path} | cat`;
  const stdout = execSync(command).toString();
  const date_string = /Date:\s+(\S*)/g.exec(stdout)[1];
  const date = new Date(date_string);

  const year = date.getUTCFullYear();
  const month = ('0' + date.getUTCMonth() + 1).substring(-2,2);
  const day = ('0' + date.getUTCDate()).substring(-2,2);
  const hour = ('0' + date.getUTCHours()).substring(-2,2);
  const min = ('0' + date.getUTCMinutes()).substring(-2,2);
  const sec = ('0' + date.getUTCSeconds()).substring(-2,2);

  const formatted_date = year + "-" + month + "-" + day + "T" + hour + ":" + min + ":" + sec + ".000Z";

  console.log("BARRY:"+formatted_date+":")

  return formatted_date;
};

module.exports = {
  generate_last_updated
};
