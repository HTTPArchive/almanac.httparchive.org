const fs = require('fs-extra');
const ejs = require('ejs');
const { get_static_lang_year_files } = require('./shared');
const { get_static_lang_files } = require('./shared');

const min_publish_date = '2019-11-11';
const sitemap_template = `templates/sitemap.ejs.xml`;
const sitemap_path = `templates/sitemap.xml`;

const last_updated_json = "config/last_updated.json";
let file_dates = {};

const generate_sitemap = async (sitemap_chapters, sitemap_languages) => {

  file_dates = JSON.parse(await fs.readFile(last_updated_json, 'utf8'));

  const urls = await get_static_pages(sitemap_languages);

  for (let sitemap_chapter of sitemap_chapters) {
    let { language, year, chapter } = sitemap_chapter;

    const lastmod = get_lastmod_date(`${language}/${year}/chapters/${chapter}.html`);
    const url = convert_file_name(`${language}/${year}/${chapter}`);

    urls.push({ url, lastmod });
  }

  urls.sort((a,b) => (a.url).localeCompare(b.url));

  let sitemap = await ejs.renderFile(sitemap_template, { urls });
  await fs.outputFile(sitemap_path, sitemap, 'utf8');

  console.log(`\n Generating sitemap.xml`);

  return sitemap_path;
};

const get_static_pages = async (sitemap_languages) => {

  let urls = [];

  // Get all of the static pages for each combination of language and year
  const files = get_static_lang_year_files(sitemap_languages);

  // Get the sitemap entries for those pages
  for (const loc of await files) {
    if (fs.existsSync(`templates/${loc}`)) {
      const lastmod = get_lastmod_date(loc);
      const url = convert_file_name(loc);

      urls.push({ url, lastmod });
    }
  }

  // Get all of the static pages with no year for each language
  const files_no_year = get_static_lang_files(sitemap_languages);

  for (const loc of await files_no_year) {
    if (fs.existsSync(`templates/${loc}`)) {
      const lastmod = get_lastmod_date(loc);
      const url = convert_file_name(loc);

      urls.push({ url, lastmod });
    }
  }

  return urls;
};

const get_lastmod_date = (file) => {
  let lastmod = file_dates[file] ? file_dates[file].date_modified : min_publish_date;
  if (lastmod.length > 10) lastmod = lastmod.substr(0, 10);
  if (lastmod < min_publish_date) lastmod = min_publish_date;
  return lastmod;
};

const convert_file_name = (url) => {
  if ( url.substr(url.length - 10) == "index.html" ) {
    return url.substr(0, url.length - 10);
  }
  if ( url.endsWith(".html")) {
    return url.substr(0, url.length - 5).replace(/_/g,'-');
  }
  return url.replace(/_/g,'-');
};

module.exports = {
  generate_sitemap
};
