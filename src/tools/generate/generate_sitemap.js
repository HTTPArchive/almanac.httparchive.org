const fs = require('fs-extra');
const ejs = require('ejs');

const min_publish_date = new Date('2019-11-05T12:00');
const sitemap_template = `templates/sitemap.ejs.xml`;
const sitemap_path = `templates/sitemap.xml`;
const static_pages = [
  'index.html',
  'table_of_contents.html',
  'methodology.html',
  'contributors.html'
];

const generate_sitemap = async (sitemap_chapters) => {
  let urls = await get_static_pages(sitemap_chapters);

  let chapter_urls = {};

  for (let sitemap_chapter of sitemap_chapters) {
    let { language, year, chapter, metadata } = sitemap_chapter;
    let key = `${year}_${chapter}`;

    let chapter_url = chapter_urls[key] || {
      loc: `en/${year}/${chapter}`,
      lastmod: null,
      alternatives: []
    };

    if (language === 'en') {
      check_meta_dates(metadata);
      chapter_url.lastmod = metadata.last_updated;
    }

    const hreflang = language;
    const href = `${language}/${year}/${chapter}`;
    chapter_url.alternatives.push({ hreflang, href });

    chapter_urls[key] = chapter_url;
  }

  urls = [...urls, ...Object.values(chapter_urls)];

  let sitemap = await ejs.renderFile(sitemap_template, { urls });
  await fs.outputFile(sitemap_path, sitemap, 'utf8');

  console.log(`\n Generating sitemap.xml`);

  return sitemap_path;
};

const get_static_pages = async (sitemap_chapters) => {
  const years_and_languages = get_years_and_languages(sitemap_chapters);

  let urls = [];
  for (let year in years_and_languages) {
    let en_urls = [];

    for (let page of static_pages) {
      const loc = `en/${year}/${page}`;
      const contents = await fs.readFile(`templates/${loc}`, 'utf-8');
      const match = contents.match(/"datePublished": "([0-9\-\+\:T]*)"/);
      const lastmod = set_min_date(match[1]);

      const alternatives = [];
      for (let language of years_and_languages[year]) {
        const hreflang = language;
        const href = `${language}/${year}/${page}`;

        alternatives.push({ hreflang, href });
      }

      en_urls.push({ loc, lastmod, alternatives });
    }

    urls = [...urls, ...en_urls];
  }

  return urls;
};

const get_years_and_languages = (sitemap_chapters) => {
  const years_and_languages = {};

  for (let { language, year } of sitemap_chapters) {
    let languages = years_and_languages[year] || [];
    languages = [...languages, language];
    years_and_languages[year] = [...new Set(languages)];
  }

  return years_and_languages;
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
    date = new Date(date.substring(0, 16));
    if (date < min_publish_date) {
      return min_publish_date.toISOString().substr(0, 10);
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
