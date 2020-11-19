const fs = require('fs-extra');
const ejs = require('ejs');

const min_publish_date = '2019-11-11';
const sitemap_template = `templates/sitemap.ejs.xml`;
const sitemap_path = `templates/sitemap.xml`;
const static_pages = [
  'index.html',
  'table_of_contents.html',
  'methodology.html',
  'contributors.html',
  'accessibility_statement.html'
];
const ebook_path = "static/pdfs/web_almanac_";

const last_updated_json = "config/last_updated.json";
let file_dates = {};

const generate_sitemap = async (sitemap_chapters,sitemap_languages) => {

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

  var languages_and_years = [];

  for (const year in sitemap_languages) {
    for (const languages in sitemap_languages[year]) {
      languages_and_years.push(`${sitemap_languages[year][languages]}/${year}`);
    }
  }

  // Get all of the static pages for each combination
  const files = languages_and_years
    .map((x) => static_pages.map((p) => `${x}/${p}`))
    .reduce((x, y) => [...x, ...y], []);

  // Get the sitemap entries for those pages
  let urls = [];

  for (const loc of await files) {
    if (fs.existsSync(`templates/${loc}`)) {
      const lastmod = get_lastmod_date(loc);
      const url = loc;

      urls.push({ url, lastmod });
    }
  }

  // For ebooks find out if the PDF exists, get lastmod from template
  for (const year in sitemap_languages) {
    for (const languages in sitemap_languages[year]) {
      const language = sitemap_languages[year][languages];
      const ebook_pdf = ebook_path + year + '_' + language + '.pdf';
      if (fs.existsSync(ebook_pdf)) {
        const lastmod = get_lastmod_date('/' + ebook_pdf);
        const url = ebook_pdf;
        urls.push({ url, lastmod });
      }
    }
  }

  return urls;
};

const get_lastmod_date = (file) => {
  let lastmod = file_dates[file] ? file_dates[file].date_modified : min_publish_date;
  if (lastmod.length > 10) lastmod = lastmod.substr(0, 10);
  if (lastmod < min_publish_date) lastmod = min_publish_date;
  return lastmod;
}

const convert_file_name = (url) => {
  if ( url.substr(url.length - 10) == "index.html" ) {
    return url.substr(0, url.length - 10);
  };
  if ( url.endsWith(".html")) {
    if ( url.endsWith("accessibility_statement.html")) {
      // Strip year from Accessibility Statement
      // TODO must fix this properly to avoid clashes
      // once we know how we'll handle this in future years
      return url.substr(0, url.length - 5).replace(/_/g,'-').replace(/\/[0-9]{4}/,'');
    } else {
      return url.substr(0, url.length - 5).replace(/_/g,'-');
    }
  };
  return url.replace(/_/g,'-');
};

module.exports = {
  generate_sitemap
};
