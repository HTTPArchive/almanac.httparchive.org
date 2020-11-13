const fs = require('fs-extra');
const ejs = require('ejs');
const { convert_file_name } = require('./shared');

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

const generate_sitemap = async (sitemap_chapters,sitemap_languages) => {

  const urls = await get_static_pages(sitemap_languages);

  for (let sitemap_chapter of sitemap_chapters) {
    let { language, year, chapter, metadata } = sitemap_chapter;

    check_meta_dates(metadata);

    const loc = `${language}/${year}/${chapter}`;
    const lastmod = metadata.last_updated;
    const url = convert_file_name(loc);

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
      const file = await fs.readFile(`templates/${loc}`, 'utf-8');
      const match = file.match(/{% block date_modified %}([0-9\-\+\:T]*)/);
      const lastmod = set_min_date(match[1]);
      const url = convert_file_name(loc);

      urls.push({ url, lastmod });
    }
  }

  // For ebooks find out if the PDF exists, get lastmod from template
  for (const year in sitemap_languages) {
    for (const languages in sitemap_languages[year]) {
      const language = sitemap_languages[year][languages];
      const ebook_pdf = ebook_path + year + '_' + language + '.pdf';
      const ebook_html = 'templates/' + language + '/' + year + '/ebook.html';
      if (fs.existsSync(ebook_pdf)) {
        if (fs.existsSync(ebook_html)) {
          const file = await fs.readFile(ebook_html, 'utf-8');
          const match = file.match(/"last_updated":"([0-9\-\+\:T]*)/);
          const lastmod = set_min_date(match[1]);
          const url = ebook_pdf;
          urls.push({ url, lastmod });
        }
      }
    }
  }

  return urls;
};

const check_meta_dates = (metadata) => {
  if (metadata) {
    let published = metadata.published;
    let last_updated = metadata.last_updated;

    if (published) {
      metadata.published = set_min_date(published);
    }
    if (last_updated) {
      metadata.last_updated = set_min_date(last_updated);
    }
  }
};

const set_min_date = (date) => {
  if (date) {
    date = date.substr(0, 10);
    if (date < min_publish_date) {
      return min_publish_date;
    } else {
      return date;
    }
  } else {
    return new Date().toISOString().substr(0, 10);
  }
};

module.exports = {
  generate_sitemap
};
