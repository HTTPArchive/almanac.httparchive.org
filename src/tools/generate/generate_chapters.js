const fs = require('fs-extra');
const showdown = require('showdown');
const ejs = require('ejs');
const prettier = require('prettier');

const { find_markdown_files, find_config_files, size_of, parse_array } = require('./shared');
const { generate_table_of_contents } = require('./generate_table_of_contents');
const { generate_header_links } = require('./generate_header_links');
const { generate_figure_ids } = require('./generate_figure_ids');
const { generate_sitemap } = require('./generate_sitemap');
const { lazy_load_content } = require('./lazy_load_content');
const { wrap_tables } = require('./wrap_tables');
const { remove_unnecessary_markup } = require('./remove_unnecessary_markup');
const { generate_ebooks } = require('./generate_ebooks');

const converter = new showdown.Converter({ tables: true, metadata: true });
converter.setFlavor('github');
converter.setOption('simpleLineBreaks', false);
converter.setOption('tablesHeaderId', false);
converter.setOption('ghMentions', false);

const generate_chapters = async () => {

  let sitemap = [];
  let sitemap_languages = {};
  let ebook_chapters = [];
  let configs = {};
  
  for (const config_file of await find_config_files()) {
    const re = (process.platform != 'win32') 
                  ? /config\/([0-9]*).json/ 
                  : /config\\([0-9]*).json/;
    const [path,year] = config_file.match(re);
    
    configs[year] = JSON.parse(await fs.readFile(`config/${year}.json`, 'utf8'));
    sitemap_languages[year] = configs[year].settings[0].supported_languages

  }

  for (const file of await find_markdown_files()) {
    const re = (process.platform != 'win32') 
                  ? /content\/(.*)\/(.*)\/(.*).md/ 
                  : /content\\(.*)\\(.*)\\(.*).md/;
    const [path, language, year, chapter] = file.match(re);

    try {
      console.log(`\n Generating chapter: ${language}, ${year}, ${chapter}`);

      const markdown = await fs.readFile(file, 'utf-8');
      const { metadata, body, toc } = await parse_file(markdown,chapter);
      if ( sitemap_languages[year].includes(language) ) {
        sitemap.push({ language, year, chapter, metadata });
      }
      ebook_chapters.push({ language, year, chapter, metadata, body, toc });

      await write_template(language, year, chapter, metadata, body, toc);
    } catch (error) {
      console.error(error);
      console.error('  Failed to generate chapter, moving onto the next one. ');
    }
  }

  await generate_ebooks(ebook_chapters,configs);

  const sitemap_path = await generate_sitemap(sitemap);
  await size_of(sitemap_path);
};

const parse_file = async (markdown,chapter) => {
  const html = converter.makeHtml(markdown);
  let body = html;

  body = generate_header_links(body);
  body = generate_figure_ids(body);
  body = wrap_tables(body);
  body = lazy_load_content(body);
  body = remove_unnecessary_markup(body);
  const toc = generate_table_of_contents(body);

  const m = converter.getMetadata();
  const chapter_number = Number(m.chapter_number);
  const authors = parse_array(m.authors);
  const reviewers = parse_array(m.reviewers);
  let translators;
  if (m.translators) {
    translators = parse_array(m.translators);
  }

  const metadata = {
    ...m,
    chapter_number,
    chapter,
    authors,
    reviewers,
    translators
  };

  return { metadata, body, toc };
};

const write_template = async (language, year, chapter, metadata, body, toc) => {
  const template = `templates/base/${year}/chapter.html`;
  const path = `templates/${language}/${year}/chapters/${chapter}.html`;

  if (fs.existsSync(template)) {
    let html = await ejs.renderFile(template, { metadata, body, toc });
    let fomatted_html = prettier.format(html, {
      parser: 'html',
      printWidth: Number.MAX_SAFE_INTEGER
    });

    await fs.outputFile(path, fomatted_html, 'utf8');
    await size_of(path);
  }
};

module.exports = {
  generate_chapters
};
