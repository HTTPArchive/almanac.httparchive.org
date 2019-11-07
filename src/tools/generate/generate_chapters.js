const fs = require('fs-extra');
const showdown = require('showdown');
const ejs = require('ejs');
const prettier = require('prettier');

const { find_files, size_of, parse_array } = require('./shared');
const { generate_table_of_contents } = require('./generate_table_of_contents');
const { generate_figure_ids } = require('./generate_figure_ids');
const { wrap_tables } = require('./wrap_tables');

const converter = new showdown.Converter({ tables: true, metadata: true });
converter.setFlavor('github');
converter.setOption('simpleLineBreaks', false);
converter.setOption('tablesHeaderId', false);

const generate_chapters = async () => {
  for (const file of await find_files()) {
    const re = /content\/(.*)\/(.*)\/(.*).md/;
    const [path, language, year, chapter] = file.match(re);

    try {
      console.log(`\n Generating chapter: ${language}, ${year}, ${chapter}`);

      const markdown = await fs.readFile(file, 'utf-8');
      const { metadata, body, toc } = await parse_file(markdown);
      await write_template(language, year, chapter, metadata, body, toc);
    } catch (error) {
      console.error(error);
      console.error('  Failed to generate chapter, moving onto the next one. ');
    }
  }
};

const parse_file = async (markdown) => {
  const html = converter.makeHtml(markdown);
  let body = html;

  body = generate_figure_ids(body);
  body = wrap_tables(body);
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

module.exports = {
  generate_chapters
};
