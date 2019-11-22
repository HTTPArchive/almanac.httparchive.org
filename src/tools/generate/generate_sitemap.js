const fs = require('fs-extra');
const ejs = require('ejs');

const min_publish_date = '2019-11-11';
const sitemap_template = `templates/sitemap.ejs.xml`;
const sitemap_path = `templates/sitemap.xml`;
const static_pages = [
  'index.html',
  'table_of_contents.html',
  'methodology.html',
  'contributors.html'
];

const generate_sitemap = async (sitemap_chapters) => {

  const urls = await get_static_pages(sitemap_chapters);

  for (let sitemap_chapter of sitemap_chapters) {
    let { language, year, chapter, metadata } = sitemap_chapter;

    check_meta_dates(metadata);

    const loc = `${language}/${year}/${chapter}`;
    const lastmod = metadata.last_updated;
    const url = strip_html_extension(loc);

    urls.push({ url, lastmod });
  }

  urls.sort((a,b) => (a.url).localeCompare(b.url));

  let sitemap = await ejs.renderFile(sitemap_template, { urls });
  await fs.outputFile(sitemap_path, sitemap, 'utf8');

  console.log(`\n Generating sitemap.xml`);

  return sitemap_path;
};

const get_static_pages = async (sitemap_chapters) => {
  // Get distinct languages and years
  const languages_and_years = [...new Set(sitemap_chapters.map((x) => `${x.language}/${x.year}`))];

  // Get all of the static pages for each combination
  const files = languages_and_years
    .map((x) => static_pages.map((p) => `${x}/${p}`))
    .reduce((x, y) => [...x, ...y], []);

  // Get the sitemap entries for those pages
  let urls = [];

  for (const loc of await files) {
    if (fs.existsSync(`templates/${loc}`)) {
      const file = await fs.readFile(`templates/${loc}`, 'utf-8');
      const match = file.match(/"datePublished": "([0-9\-\+\:T]*)"/);
      const lastmod = set_min_date(match[1]);
      const url = strip_html_extension(loc);

      urls.push({ url, lastmod });
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

const strip_html_extension = (url) => {
  if ( url.substr(url.length - 10) == "index.html" ) {
    return url.substr(0, url.length - 10);
  };
  if ( url.substr(url.length - 5) == ".html" ) {
    return url.substr(0, url.length - 5);
  };
  return url;
};

module.exports = {
  generate_sitemap
};
