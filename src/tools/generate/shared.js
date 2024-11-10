const fs = require('fs-extra');
const recursive = require('recursive-readdir');
const showdown = require('showdown');
const static_pages_lang_year = [
  'index.html',
  'table_of_contents.html',
  'methodology.html',
  'contributors.html',
  'stories/page_content.html',
  'stories/user_experience.html',
  'stories/content_publishing.html',
  'stories/content_distribution.html'
];
const static_pages_lang = [
  'accessibility_statement.html'
];


const simpleConverter = new showdown.Converter();
simpleConverter.setFlavor('github');
simpleConverter.setOption('simpleLineBreaks', false);
simpleConverter.setOption('tablesHeaderId', false);
simpleConverter.setOption('ghMentions', false);

const convertSimpleMarkdown = (text) => {
  // Showdown replaces & with &amp; so convert those back to avoid escape issues
  let convertedText = text?.replace(/&amp;/g,'&');
  convertedText = simpleConverter.makeHtml(convertedText);
  // As we've converted again, need to convert back &amp; again
  convertedText = convertedText?.replace(/&amp;/g,'&');
  // Strip paragraph tags from beginning and end
  convertedText = convertedText?.replace(/^<p>/,'');
  convertedText = convertedText?.replace(/<\/p>$/,'');
  return convertedText;
};

const find_template_files = async () => {
  const filter = (file, stats) => {
    const isHtml = file && file.endsWith('.html');
    const isDirectory = stats && stats.isDirectory();

    return !isHtml && !isDirectory;
  };

  return await recursive('templates', [filter]);
};

const find_markdown_files = async () => {
  const filter = (file, stats) => {
    const isMd = file && file.endsWith('.md');
    const isDirectory = stats && stats.isDirectory();

    return !isMd && !isDirectory;
  };

  return await recursive('content', [filter]);
};

const find_asset_files = async () => {
  const filter = (file, stats) => {
    const isJS = file && file.endsWith('.js');
    const isCSS = file && file.endsWith('.css');
    const isPDF = file && file.endsWith('.pdf');
    const isDirectory = stats && stats.isDirectory();

    return !isJS && !isCSS && !isPDF && !isDirectory;
  };

  return await recursive('static', [filter]);
};

const find_config_files = async () => {
  const filter = (file, stats) => {
    const isJSON = file && file.search(/[0-9]{4}.json$/) != -1

    return !isJSON;
  };

  return await recursive('config', [filter]);
};

function get_yearly_contributors(year) {
  const contributorsData = JSON.parse(fs.readFileSync('config/contributors.json', 'utf8'));
  const yearlyContributors = {};

  for (const contributorKey in contributorsData) {
    const yearContributions = contributorsData[contributorKey].teams[year];
    if (typeof yearContributions == "object") {
      yearlyContributors[contributorKey] = { ...contributorsData[contributorKey] }
      yearlyContributors[contributorKey].teams = yearContributions;
    }
  }

  return yearlyContributors;
}

const get_yearly_configs = async () => {

  let configs = {};

  for (const config_file of await find_config_files()) {
    const re = (process.platform != 'win32')
                  ? /config\/([0-9]*).json/
                  : /config\\([0-9]*).json/;
    const [path,year] = config_file.match(re);

    configs[year] = JSON.parse(await fs.readFile(`config/${year}.json`, 'utf8'));

    configs[year]["contributors"] = get_yearly_contributors(year);

  }
  return configs;
};

const size_of = async (path) => {
  let b = (await fs.stat(path)).size;

  let u = 0,
    s = 1024;
  while (b >= s || -b >= s) {
    b /= s;
    u++;
  }
  let size = (u ? b.toFixed(1) + ' ' : b) + ' KMGTPEZY'[u] + 'B';

  console.log(` - Output file size: ${size}`);
};

const parse_array = (array_as_string) => {
  return (array_as_string == "[]" ? null : array_as_string
    .substring(1, array_as_string.length - 1)
    .split(',')
    .map((value) => value.trim()));
};

const get_languages_and_years_as_array = (language_array) => {

  var languages_and_years = [];
  var languages = [];

  for (const year in language_array) {
    for (const language in language_array[year]) {
      languages_and_years.push(`${language_array[year][language]}/${year}`);
      // Get a list of just languages as well
      const lang_code = `${language_array[year][language]}`;
      if (!languages.includes(`${lang_code}`)) languages.push(`${lang_code}`);
    }
  }

  return [languages_and_years,languages];

};

const get_static_lang_year_files = (language_array) => {

  var languages_and_years = [];
  var languages = [];

  [languages_and_years, languages] = get_languages_and_years_as_array(language_array);

  // Get all of the static pages for each combination of language and year
  const files = languages_and_years
    .map((x) => static_pages_lang_year.map((p) => `${x}/${p}`))
    .reduce((x, y) => [...x, ...y], []);

  return files;

};

const get_static_lang_files = (language_array) => {

  var languages_and_years = [];
  var languages = [];

  [languages_and_years, languages] = get_languages_and_years_as_array(language_array);

  // Get all of the static pages for each language
  const files = languages
    .map((x) => static_pages_lang.map((p) => `${x}/${p}`))
    .reduce((x, y) => [...x, ...y], []);

  return files;

};

module.exports = {
  convertSimpleMarkdown,
  find_markdown_files,
  find_template_files,
  find_asset_files,
  find_config_files,
  get_yearly_configs,
  size_of,
  parse_array,
  get_static_lang_year_files,
  get_static_lang_files
};
