const fs = require('fs-extra');
const showdown = require('showdown');
const ejs = require('ejs');
const prettier = require('prettier');

//Chapters may exist but not be ready to be launched so do not include in sitemap
const sitemap_languages = ['en'];

const { find_files, size_of, parse_array } = require('./shared');
const { generate_table_of_contents } = require('./generate_table_of_contents');
const { generate_figure_ids } = require('./generate_figure_ids');
const { generate_sitemap } = require('./generate_sitemap');
const { lazy_load_content } = require('./lazy_load_content');
const { wrap_tables } = require('./wrap_tables');
const { remove_unnecessary_markup } = require('./remove_unnecessary_markup');

const converter = new showdown.Converter({ tables: true, metadata: true });
converter.setFlavor('github');
converter.setOption('simpleLineBreaks', false);
converter.setOption('tablesHeaderId', false);
converter.setOption('ghMentions', false);

const generate_chapters = async () => {
  let sitemap = [];
  for (const file of await find_files()) {
    const re = (process.platform != 'win32') 
                  ? /content\/(.*)\/(.*)\/(.*).md/ 
                  : /content\\(.*)\\(.*)\\(.*).md/;
    const [path, language, year, chapter] = file.match(re);

    try {
      console.log(`\n Generating chapter: ${language}, ${year}, ${chapter}`);

      const markdown = await fs.readFile(file, 'utf-8');
      const { metadata, body, toc } = await parse_file(markdown,chapter);
      if ( sitemap_languages.includes(language) ) {
        sitemap.push({ language, year, chapter, metadata });
      }
      await write_template(language, year, chapter, metadata, body, toc);
    } catch (error) {
      console.error(error);
      console.error('  Failed to generate chapter, moving onto the next one. ');
    }
  }

  const sitemap_path = await generate_sitemap(sitemap);
  await size_of(sitemap_path);
};

const parse_file = async (markdown,chapter) => {
  const html = converter.makeHtml(markdown);
  let body = html;

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
