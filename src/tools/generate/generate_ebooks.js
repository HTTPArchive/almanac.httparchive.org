const fs = require('fs-extra');
const ejs = require('ejs');
const { size_of } = require('./shared');

const update_links = (chapter, chapter_config) => {
  let body = chapter.body;
  // Replace current chapter links to full anchor link (e.g. #introduction -> #javascript-introduction)
  body = body.replace(/ href="#/g,' href="#' + chapter.metadata.chapter + '-');
  // Replace current chapter fig ids to full id (e.g. id="fig-1" -> id="fig-1-1")
  body = body.replace(/id="fig-([0-9_-])/g,'id="fig-' + chapter_config.chapter_number + '-$1');
  // Add ebook=true to figure_markup macros
  body = body.replace(/figure_markup\(/g,'figure_markup(ebook=true,');
  // Add ebook=true to figure_link templates
  body = body.replace(/figure_link\(/g,'figure_link(ebook=true,');
  // Remove figure_drodowns as not needed
  body = body.replace(/{{\s*figure_dropdown.*?}}/gsm,'');
  // For PDFs tables cannot be in figures
  body = body.replace(/<figure (id="[^"]*?")><div class="table-wrap"><div class="table-wrap-container"><table>/gs,'<table $1>');
  body = body.replace(/(<\/table><\/div><\/div>\n *)<figcaption>(.*?)<\/figcaption>(\n *)<\/figure>/gs,'</table><p class="table-caption">$2</p>');
  // Replace current chapter header ids to full id (e.g. <h2 id="introduction"> -> <h2 id="javascript-introduction">)
  body = body.replace(/<h([0-6]) id="/g,'<h$1 id="' + chapter.metadata.chapter + '-');
  // Replace other chapter references with hash to anchor link (e.g. ./javascript#fig-1 -> #javascript-fig-1)
  body = body.replace(/ href=".\/([a-z0-9-]+)#/g,' href="#$1-');
  // Correct figure links, which are already fully qualified
  body = body.replace(/ href="#([a-z0-9-]*)-fig-([0-9]*)"/g,' href="#fig-' + chapter_config.chapter_number + '-$2"');
  // Replace other chapter references to anchor link (e.g. ./javascript -> #javascript)
  body = body.replace(/ href="\.\//g,' href="#');
  // Replace other year chapter references with absolute line (e.g. ../2019/http -> https://almanac.httparchive.org/en/2019/http)
  body = body.replace(/ href="\.\.\//g,' href="https://almanac.httparchive.org/{{ lang }}/');
  // For external links add footnote span - unless the link text is the address (begining with http, www or @ for Twitter ids)
  body = body.replace(/ href="(http[^"]*?)"([^>]*?)>((?!(?:www|http|@))[^<]*?)<\/a>/g,' href="$1"$2>$3</a><span class="fn">$1</span>');
  // Replace figure image links to full site, to avoid 0.0.0.0:8080 links
  body = body.replace(/ href="\/static\/images/g,' href="https://almanac.httparchive.org/static/images');
  // Remove lazy-loading attributes
  body = body.replace(/ loading="lazy"/g,'');
  return body;
}

const generate_ebooks = async (ebook_chapters,configs) => {

  // Get distinct years
  const years = [...new Set(ebook_chapters.map((x) => `${x.year}`))];

  for (const year of years) {

    const config = configs[year];
    const languages = config.settings[0].ebook_languages;

    for (let language of languages) {
      let ebook = { language, config, toc: [], parts: [] };

      for (let part_config of config.outline) {
        let part = {
          title: part_config.part,
          chapters: []
        };

        for (let chapter_config of part_config.chapters) {

          //Skip any TODO chapters as won't be found
          if (chapter_config.todo === true) continue;

          let chapter = ebook_chapters.find(
            (c) => c.year === year && c.language === language
                    && c.metadata.chapter == chapter_config.slug
          );

          chapter.body = update_links(chapter, chapter_config);

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
  const template = `templates/base/ebook.ejs.html`;
  const path = `templates/${language}/${year}/ebook.html`;

  let html = await ejs.renderFile(template, { ebook });
  await fs.outputFile(path, html, 'utf8');
  await size_of(path);
};

module.exports = {
  generate_ebooks
};
