const fs = require('fs-extra');
const ejs = require('ejs');
const prettier = require('prettier');

const { size_of } = require('./shared');

// TODO: Make this more dynamic.
const ebooks_to_generate = {
  '2019': ['en','ja']
};

const update_links = (chapter) => {
  let body = chapter.body;
  // Replace current chapter links to full anchor link (e.g. #introduction -> #javascript-introduction)
  body = body.replace(/href="#/g,'href="#' + chapter.metadata.chapter + '-');
  // Replace aria-labelledby ids to full id (e.g. aria-labelledby="fig-1..." -> aria-labelledby="javascript-fig-1...")
  body = body.replace(/aria-labelledby="fig([0-9_-])/g,'aria-labelledby="' + chapter.metadata.chapter + '-fig$1');
  // Replace aria-describedby ids to full id (e.g. aria-describedby="fig-1" -> aria-describedby="javascript-fig-1")
  body = body.replace(/aria-describedby="fig([0-9_-])/g,'aria-describedby="' + chapter.metadata.chapter + '-fig$1');
  // Replace current chapter fig ids to full id (e.g. id="fig-1" -> id="javascript-fig-1")
  body = body.replace(/id="fig([0-9_-])/g,'id="' + chapter.metadata.chapter + '-fig$1');
  // Replace current chapter header ids to full id (e.g. <h2 id="introduction"> -> <h2 id="javascript-introduction">)
  body = body.replace(/<h([0-6]) id="/g,'<h$1 id="' + chapter.metadata.chapter + '-');
  // Replace other chapter references with hash to anchor link (e.g. ./javascript#fig-1 -> #javascript-fig-1)
  body = body.replace(/<a href=".\/([a-z0-9-]+)#/g,'<a href="#$1-');
  // Replace other chapter references to anchor link (e.g. ./javascript -> #javascript)
  body = body.replace(/<a href=".\//g,'<a href="#');
  // For external links add footnote span
  body = body.replace(/href="(http.*?)"(.*?)>(.*?)<\/a>/g,'href="$1"$2>$3<span class="fn">$1</span></a>');
  // Replace figure image links to full site, to avoid 127.0.0.1:8080 links
  body = body.replace(/<a href="\/static\/images/g,'<a href="https://almanac.httparchive.org/static/images');
  // Remove lazy-loading attributes
  body = body.replace(/ loading="lazy"/g,'');
  return body;
}

const generate_ebooks = async (ebook_chapters) => {
  for (let [year, languages] of Object.entries(ebooks_to_generate)) {
    let config = JSON.parse(await fs.readFile(`config/${year}.json`, 'utf8'));

    for (let language of languages) {
      let ebook = { language, config, toc: [], parts: [] };

      for (let part_config of config.outline) {
        let part = {
          title: part_config.part,
          chapters: []
        };

        for (let chapter_config of part_config.chapters) {
          let chapter = ebook_chapters.find(
            (c) => c.language === language && c.metadata.chapter_number == chapter_config.chapter
          );

          chapter.body = update_links(chapter);

          part.chapters.push({ ...chapter_config, ...chapter });
        }

        ebook.parts.push(part);
      }

      console.log(`\n Generating ebook: ${language}, ${year}`);
      await write_template(language, year, ebook);
    }
  }
};

const write_template = async (language, year, ebook) => {
  const template = `templates/base/${year}/ebook.ejs.html`;
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
