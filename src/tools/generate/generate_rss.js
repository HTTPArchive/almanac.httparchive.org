const fs = require('fs-extra');
const ejs = require('ejs');
const { size_of } = require('./shared');

const min_publish_date = '2019-11-11T00:00:00.000Z';
const rss_template = `templates/base/rss.ejs.xml`;
const rss_file = `rss.xml`;
const ebook_path = "static/pdfs/web_almanac_";

const last_updated_json = "config/last_updated.json";
let file_dates = {};

const generate_rss = async (configs, rss_chapters, rss_languages) => {

  const rss_languages_only = new Set();

  const rss_last_updated_date = {};

  for (const year in rss_languages) {
    for (const languages in rss_languages[year]) {
      rss_languages_only.add(rss_languages[year][languages]);
    }
  }

  file_dates = JSON.parse(await fs.readFile(last_updated_json, 'utf8'));

  const urls = await get_static_pages(configs, rss_languages);

  for (let rss_chapter of rss_chapters) {
    let { language, year, chapter, title, description, authors } = rss_chapter;

    const pubdate = get_publish_date(`${language}/${year}/chapters/${chapter}.html`);
    const updatedate = get_update_date(`${language}/${year}/chapters/${chapter}.html`);
    const url = convert_file_name(`${language}/${year}/${chapter}`);
    title = `${title} (${year})`;
    authors = authors.map(author => configs[year].contributors[author].name.replace(/\\/g, '\\\\').replace(/"/g, '\\"'));
    authors = '"' + authors.join('","') + '"';

    // Capture the latest updated date as the overall rss updated date
    if (!rss_last_updated_date[language] || updatedate > rss_last_updated_date[language]) {
      rss_last_updated_date[language] = updatedate;
    }

    urls.push({ language, url, pubdate, updatedate, title, description, authors });
  }

  urls.sort((a,b) => (a.url).localeCompare(b.url));

  for (let language of rss_languages_only) {
    const updated_date = rss_last_updated_date[language];
    let rss = await ejs.renderFile(rss_template, { urls, language, updated_date });
    const rss_filename = `templates/${language}/${rss_file}`;

    console.log(`Generating ${language}/${rss_file}`);
    await fs.outputFile(rss_filename, rss, 'utf8');
    await size_of(rss_filename);
  }

  return;
};

const get_static_pages = async (configs, rss_languages) => {

  let urls = [];

  // For ebooks find out if the PDF exists, get pubdate from template
  for (const year in rss_languages) {
    for (const languages in rss_languages[year]) {
      const language = rss_languages[year][languages];
      const ebook_pdf = ebook_path + year + '_' + language + '.pdf';
      if (fs.existsSync(ebook_pdf)) {
        const pubdate = get_publish_date('/' + ebook_pdf);
        const updatedate = get_update_date('/' + ebook_pdf);
        const url = ebook_pdf;
        const title = `{{ self.ebook_title() }} (${year})`;
        const description = "{{ self.ebook_title() }}";
        let authors = Object.values(configs[year].contributors).filter(contributor => contributor.teams.includes("authors")).map(contributor => contributor.name.replace(/\\/g, '\\\\').replace(/"/g, '\\"'));
        authors = '"' + authors.join('","') + '"';
        urls.push({ language, url, pubdate, updatedate, title, description, authors });
      }
    }
  }

  return urls;
};

const get_publish_date = (file) => {
  let pubdate = file_dates[file] ? file_dates[file].date_published : min_publish_date;
  if (pubdate < min_publish_date) pubdate = min_publish_date;
  return pubdate;
};

const get_update_date = (file) => {
  let pubdate = file_dates[file] ? file_dates[file].date_modified : min_publish_date;
  if (pubdate < min_publish_date) pubdate = min_publish_date;
  return pubdate;
};

const convert_file_name = (url) => {
  if ( url.substr(url.length - 10) == "index.html" ) {
    return url.substr(0, url.length - 10);
  };
  if ( url.endsWith(".html")) {
    return url.substr(0, url.length - 5).replace(/_/g,'-');
  };
  return url.replace(/_/g,'-');
};

module.exports = {
  generate_rss
};
