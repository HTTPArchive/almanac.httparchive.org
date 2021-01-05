const fs = require('fs-extra');
const { find_markdown_files } = require('./shared');
const { find_asset_files } = require('./shared');
const { get_yearly_configs } = require('./shared');
const crypto = require('crypto');

const static_pages = [
  'index.html',
  'table_of_contents.html',
  'methodology.html',
  'contributors.html',
  'accessibility_statement.html',
  'ebook.html',
  'stories/page_content.html'
];

const path = "config/last_updated.json";

let supported_languages = {};
let configs = {};

let file_dates = {};

let now = "";

const check_and_update_date = (file, hash, size) => {

  //file = convert_file_name(file);
  file=file.replace(/content\/(.*)\/([0-9]*)\/(.*)\.md$/,"$1/$2/chapters/$3.html");

  if (file_dates[file]) {

    if (file_dates[file].hash !== hash) {
      console.log("Updating existing date for: " + file + " to " + now);
      file_dates[file].hash = hash;
      file_dates[file].date_modified = now;
      if (size) file_dates[file].size = size;
      return;
    }

    // No update to be done
    return;
  }

  console.log("Adding new date for: " + file + " to " + now);
  if (size) {
    file_dates[file] = {
      "date_published": now,
      "date_modified": now,
      "hash": hash,
      "size": size
    };
  } else {
    file_dates[file] = {
      "date_published": now,
      "date_modified": now,
      "hash": hash
    };
  }

}

const get_chapter_dates = async () => {

  for (const file of await find_markdown_files()) {

    // Read the content of the file
    let content = await fs.readFile(file, 'utf-8');
    let hash = crypto.createHash('md5').update(content).digest("hex")
    check_and_update_date(file, hash, null);

  }
};

const get_asset_file_dates = async () => {

  for (const file of await find_asset_files()) {

    // Read the content of the file
    let content = await fs.readFile(file, 'utf-8');
    let hash = crypto.createHash('md5').update(content).digest("hex")
    let size = null;
    if (file.endsWith('.pdf')) {
      size = Math.round(fs.statSync(file).size / (1024*1024),0);
    }
    check_and_update_date('/' + file, hash, size);

  }
};

const get_template_pages_dates = async (supported_languages) => {

  var languages_and_years = [];

  for (const year in supported_languages) {
    for (const languages in supported_languages[year]) {
      languages_and_years.push(`${supported_languages[year][languages]}/${year}`);
    }
  }

  // Get all of the static pages for each combination
  const files = languages_and_years
    .map((x) => static_pages.map((p) => `${x}/${p}`))
    .reduce((x, y) => [...x, ...y], []);

  // Get the sitemap entries for those pages
  let static_pages_dates = [];

  for (const file of await files) {
    if (fs.existsSync(`templates/${file}`)) {
      let content = await fs.readFile(`templates/${file}`, 'utf-8');
      let hash = crypto.createHash('md5').update(content).digest("hex");
      check_and_update_date(file, hash, null);
    }
  }

  return static_pages_dates;
};


const write_files_dates_file = async () => {

  // Sort order is not guaranteed, so let's sort just to make sure no meaningless changes
  var sorted_dates = {};
  Object.keys(file_dates).sort().forEach(function(key) {
    sorted_dates[key] = file_dates[key];
  });
  file_dates = sorted_dates;

  console.log("Writing file")

  try {
    fs.writeFile(path, JSON.stringify(file_dates, null, 2), (err) => {
      if (err) console.log('Error')
    });
  } catch(err) {
    console.error('  Failed to generate file' + err);
  }
}

const generate_timestamps = async () => {

  now = new Date(Date.now());
  now = new Date (Date.UTC(now.getFullYear(),now.getMonth(), now.getDate())).toISOString();
  if (fs.existsSync(path)) {
    file_dates = JSON.parse(await fs.readFile(path, 'utf8'));
  }

  configs = await get_yearly_configs();
  for (const year in configs) {
    supported_languages[year] = configs[year].settings[0].supported_languages;
  }

  await get_chapter_dates();
  await get_template_pages_dates(supported_languages);
  await get_asset_file_dates();
  await write_files_dates_file();

}

(async () => {
  try {
    await generate_timestamps();
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
})();

