const fs = require('fs-extra');
const showdown = require('showdown');
const ejs = require('ejs');
const prettier = require('prettier');
const recursive = require('recursive-readdir');

const { generate_table_of_contents } = require('./generate_table_of_contents');
const { generate_figure_ids } = require('./generate_figure_ids');

const converter = new showdown.Converter({ tables: true, metadata: true });
converter.setFlavor('github');
converter.setOption('simpleLineBreaks', false);
converter.setOption('tablesHeaderId', false);

const min_publish_date = new Date('2019-11-05T12:00');
const sitemap_path = `templates/sitemap.xml`;

var config = {};
var chapters_config = [];
var todo_chapters = [];

const generate_chapters = async () => {

  //Read in the Chapters to see which ones are still to do (needed for sitemap)
  await read_config('2019');
  chapters_config = config.outline.map(function(item) { return item["chapters"]; }).flat();
  todo_chapters = chapters_config.filter(function(chapter_obj) {return chapter_obj.todo}).map(function(item) { return item["title"]; });

  await write_sitemap_start('en','2019');
  for (const file of await find_files()) {
    const re = /content\/(.*)\/(.*)\/(.*).md/;
    const [path, language, year, chapter] = file.match(re);

    try {
      console.log(`\n Generating chapter: ${language}, ${year}, ${chapter}`);

      const markdown = await fs.readFile(file, 'utf-8');
      const { metadata, body, toc } = await parse_file(markdown);
      check_meta_dates(metadata);
      await write_template(language, year, chapter, metadata, body, toc);
      await write_sitemap(language, year, chapter, metadata);
    } catch (error) {
      console.error(error);
      console.error('  Failed to generate chapter, moving onto the next one. ');
    }
  }
  await write_sitemap_end();
};

const read_config = async (year) => {
  try {
  config_file = fs.readFileSync('config/'+year+'.json');
  config = JSON.parse(config_file);
  } catch  {
    console.error(error);
    console.error('  Failed to read config. ');
  }
}

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
}

const set_min_date = (date) => {
  if (date) {
    date = new Date(date.substring(0,16));
    if (date < min_publish_date) {
      return min_publish_date.toISOString().substr(0, 10);
    } else {
      return date;
    }
  } else {
    return new Date().toISOString().substr(0, 10);
  }
}

const find_files = async () => {
  const filter = (file, stats) => {
    const isMd = file && file.endsWith('.md');
    const isDirectory = stats && stats.isDirectory();

    return !isMd && !isDirectory;
  };

  return await recursive('content', [filter]);
};

const parse_file = async (markdown) => {
  const html = converter.makeHtml(markdown);
  const body = generate_figure_ids(html);
  const toc = generate_table_of_contents(body);

  const m = converter.getMetadata();
  const chapter_number = Number(m.chapter_number);
  const authors = parse_array(m.authors);
  const reviewers = parse_array(m.reviewers);

  const metadata = {
    ...m,
    chapter_number,
    authors,
    reviewers
  };

  return { metadata, body, toc };
};

const write_template = async (language, year, chapter, metadata, body, toc) => {
  const template = `templates/${language}/${year}/chapter.html`;
  const path = `templates/${language}/${year}/chapters/${chapter}.html`;

  let html = await ejs.renderFile(template, { metadata, body, toc });
  let fomatted_html = prettier.format(html, {
    parser: 'html',
    printWidth: Number.MAX_SAFE_INTEGER
  });

  await fs.outputFile(path, fomatted_html, 'utf8');
  await size_of(path);
};

const write_sitemap_start = async (language, year) => {
  
  await fs.outputFile(sitemap_path, '<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">\n', 'utf8');

  await write_sitemap_for_file('templates/' + language + '/' + year + '/index.html', 'https://almanac.httparchive.org/en/2019/index.html');
  await write_sitemap_for_file('templates/' + language + '/' + year + '/table_of_contents.html', 'https://almanac.httparchive.org/en/2019/table_of_contents.html');
  await write_sitemap_for_file('templates/' + language + '/' + year + '/methodology.html', 'https://almanac.httparchive.org/en/2019/methodology.html');
  await write_sitemap_for_file('templates/' + language + '/' + year + '/contributors.html', 'https://almanac.httparchive.org/en/2019/contributors.html');

};

const write_sitemap_for_file = async (file, url) => {
  
  var lastmod;

  let static_file = fs.readFileSync(file).toString();
  var rx = /"datePublished": "([0-9\-\+\:T]*)"/;
  var last_updated = (rx.exec(static_file));
  if (last_updated) last_updated = last_updated[1];
  if (last_updated) {

    lastmod = set_min_date(last_updated);

    let sitemap_url = '<url>\n';
    sitemap_url = sitemap_url + '<loc>' + url + '</loc>\n';
    sitemap_url = sitemap_url + '<lastmod>' + lastmod + '</lastmod>\n';
    sitemap_url = sitemap_url + '</url>\n';
    await fs.appendFile(sitemap_path, sitemap_url, 'utf8');
  }
}

const write_sitemap = async (language, year, chapter, metadata) => {

  let last_updated = metadata.last_updated;

  if (last_updated) {
    last_updated = new Date(last_updated.substring(0,16));
    if (last_updated) {
      lastmod = last_updated.toISOString().substr(0, 10);
      if (!todo_chapters.includes(metadata.title)) {
        let sitemap_url = '<url>\n';
        sitemap_url = sitemap_url + '<loc>https://almanac.httparchive.org/'+language+'/'+year+'/'+chapter+'</loc>\n';
        sitemap_url = sitemap_url + '<lastmod>' + lastmod + '</lastmod>\n';
        sitemap_url = sitemap_url + '</url>\n';
        await fs.appendFile(sitemap_path, sitemap_url, 'utf8');
      }  
    }
  }
};

const write_sitemap_end = async () => {
  
  await fs.appendFile(sitemap_path, '</urlset>');

  console.log("\nGenerated Sitemap");
  await size_of(sitemap_path);
}

const parse_array = (s) => s.substring(1, s.length - 1)
                            .split(',')
                            .map((value) => value.trim());

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

const ignorelist = ['.DS_Store'];
const ignore = (file) => ignorelist.find((f) => f === file);

module.exports = {
  generate_chapters
};
