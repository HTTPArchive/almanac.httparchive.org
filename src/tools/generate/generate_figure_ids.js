const { JSDOM } = require('jsdom');
const slugify = require('slugify');

const generate_figure_ids = (html) => {
  const dom = new JSDOM(html);
  const all_figures = Object.values(dom.window.document.querySelectorAll('figure'));

  for (const figure of all_figures) {
    if (figure.id) continue;

    const figcaption = figure.querySelector('figcaption');

    figure.id = slugify(figcaption.textContent, {
      replacement: '-',
      remove: /[^\w\s]|_/,
      lower: true
    });
  }

  const body = dom.window.document.body.outerHTML;
  return body;
};

module.exports = {
  generate_figure_ids
};
