const fs = require('fs-extra');
const showdown = require('showdown');
const ejs = require('ejs');
const { generate_table_of_contents } = require('./generate_table_of_contents');

const converter = new showdown.Converter({ tables: true, metadata: true });
converter.setFlavor('github');

const generate_chapters = async () => {
  for (let language of await fs.readdir('content')) {
    for (let year of await fs.readdir(`content/${language}`)) {
      for (let file of await fs.readdir(`content/${language}/${year}`)) {
        let markdown = await fs.readFile(`content/${language}/${year}/${file}`, 'utf-8');
        let chapter = file.replace('.md', '');

        console.log(`\n Generating chapter: ${language}, ${year}, ${chapter}`);

        let { metadata, body, toc } = await parse_file(markdown);

        await write_template(language, year, chapter, metadata, body, toc);
      }
    }
  }
};

const parse_file = async (markdown) => {
  const body = converter.makeHtml(markdown);
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

  await fs.outputFile(path, html, 'utf8');

  await size_of(path);
};

const parse_array = (s) => s.substring(1, s.length - 1).split(',');

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

module.exports = {
  generate_chapters
};
