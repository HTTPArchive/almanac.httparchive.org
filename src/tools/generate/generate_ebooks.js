const fs = require('fs-extra');
const ejs = require('ejs');
const prettier = require('prettier');

const { size_of } = require('./shared');

// TODO: Make this more dynamic.
const ebooks_to_generate = {
  '2019': ['en']
};

const generate_ebooks = async (ebook_chapters) => {
  for (let [year, languages] of Object.entries(ebooks_to_generate)) {
    let config = JSON.parse(await fs.readFile(`config/${year}.json`, 'utf8'));

    for (let language of languages) {
      let ebook = { language, toc: [], parts: [] };

      for (let part_config of config.outline) {
        let part = {
          title: part_config.part,
          chapters: []
        };

        for (let chapter_config of part_config.chapters) {
          let chapter = ebook_chapters.find(
            (c) => c.language === language && c.metadata.chapter_number == chapter_config.chapter
          );

          part.chapters.push({ ...chapter_config, ...chapter });
        }

        ebook.parts.push(part);
      }

      console.log(`\n Generating ebook: ${language}, ${year}`);
      await write_template(languages, year, ebook);
    }
  }
};

const write_template = async (language, year, ebook) => {
  const template = `templates/${language}/${year}/ebook.ejs.html`;
  const path = `templates/${language}/${year}/ebook.html`;

  if (fs.existsSync(template)) {
    let html = await ejs.renderFile(template, { ebook });
    let fomatted_html = prettier.format(html, {
      parser: 'html',
      printWidth: Number.MAX_SAFE_INTEGER
    });

    await fs.outputFile(path, fomatted_html, 'utf8');
    await size_of(path);
  }
};

module.exports = {
  generate_ebooks
};
