const fs = require('fs-extra');
const showdown = require('showdown');
const ejs = require('ejs');
const prettier = require('prettier');

const { find_markdown_files, get_yearly_configs, size_of, parse_array } = require('./shared');
const { generate_table_of_contents } = require('./generate_table_of_contents');
const { generate_header_links } = require('./generate_header_links');
const { generate_figure_ids } = require('./generate_figure_ids');
const { generate_featured_chapters, generate_chapter_featured_quote } = require('./generate_featured_chapters');
const { generate_sitemap } = require('./generate_sitemap');
const { lazy_load_content } = require('./lazy_load_content');
const { wrap_tables } = require('./wrap_tables');
const { remove_unnecessary_markup } = require('./remove_unnecessary_markup');
const { generate_ebooks } = require('./generate_ebooks');
const { generate_js } = require('./generate_js');

const converter = new showdown.Converter({ tables: true, metadata: true });
converter.setFlavor('github');
converter.setOption('simpleLineBreaks', false);
converter.setOption('tablesHeaderId', false);
converter.setOption('ghMentions', false);

const generate_chapters = async (chapter_match) => {

  let sitemap = [];
  let sitemap_languages = {};
  let ebook_chapters = [];
  let configs = {};
  let featured_quotes = {};
  let re;
  
  configs = await get_yearly_configs();
  for (const year in configs) {  
    sitemap_languages[year] = configs[year].settings[0].supported_languages;
  }

  if (chapter_match) {
    // Remove any trailing .md and replace all paths with brackets to capture components
    // en/2019/javascript.md -> (en)/(2019)/(javascript).md
    chapter_match = chapter_match.replace(/\.md$/,'');
    chapter_match = chapter_match.replace(/^content[\/\\]*/,'');
    chapter_match = (process.platform != 'win32')
                ? 'content\/' +  '(' + chapter_match.replace(/\//g,')/(') + ')\.md'
                : 'content\\\\' +  '(' + chapter_match.replace(/\\/g,')\\\\(') + ')\.md';
    re = new RegExp(chapter_match);
  } else {
    re = (process.platform != 'win32')
                ? /content\/(.*)\/(.*)\/(.*).md/
                : /content\\(.*)\\(.*)\\(.*).md/;
  }

  for (const file of await find_markdown_files()) {

    let path, language, year, chapter;

    try {
      [path, language, year, chapter] = file.match(re);
    } catch(error) {
      // No match - skip to next in for loop
      continue;
    }

    try {
      console.log(`\n Generating chapter: ${language}, ${year}, ${chapter}`);

      const markdown = await fs.readFile(file, 'utf-8');
      const { metadata, body, toc } = await parse_file(markdown,chapter);
      const chapter_featured_quote = generate_chapter_featured_quote(metadata);
      if (Object.keys(chapter_featured_quote).length > 0) {
        if (!(language in featured_quotes)) {
          featured_quotes[language] = {};
        }
        if (!(year in featured_quotes[language])) {
          featured_quotes[language][year] = {};
        }
        featured_quotes[language][year][chapter] = chapter_featured_quote;
      }
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

  // For partial generation stop there, else generate everything else
  if (!chapter_match) {
    await generate_featured_chapters(featured_quotes);
    await generate_ebooks(ebook_chapters,configs);
    await generate_js();

    const sitemap_path = await generate_sitemap(sitemap,sitemap_languages);
    await size_of(sitemap_path);
  }

};

const parse_file = async (markdown,chapter) => {
  const html = converter.makeHtml(markdown);
  let body = html;

  const m = converter.getMetadata();
  body = generate_header_links(body);
  body = generate_figure_ids(body);
  body = wrap_tables(body);
  body = lazy_load_content(body);
  body = remove_unnecessary_markup(body);
  const toc = generate_table_of_contents(body);

  const chapter_number = Number(m.chapter_number);
  const authors = parse_array(m.authors);
  const reviewers = parse_array(m.reviewers);
  let translators;
  if (m.translators) {
    translators = parse_array(m.translators);
  }
  let analysts;
  if (m.analysts) {
    analysts = parse_array(m.analysts);
  }

  const metadata = {
    ...m,
    chapter_number,
    chapter,
    authors,
    reviewers,
    translators,
    analysts
  };

  return { metadata, body, toc };
};

const write_template = async (language, year, chapter, metadata, body, toc) => {
  const template = `templates/base/2019/chapter.ejs.html`;
  const path = `templates/${language}/${year}/chapters/${chapter}.html`;

  if (fs.existsSync(template)) {
    body = prettier.format(body, {
      parser: 'html',
      printWidth: Number.MAX_SAFE_INTEGER
    });
    let html = await ejs.renderFile(template, { metadata, body, toc });

    await fs.outputFile(path, html, 'utf8');
    await size_of(path);
  }
};

module.exports = {
  generate_chapters
};
