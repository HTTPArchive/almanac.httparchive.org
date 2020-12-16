const jsdom = require("jsdom");
const { JSDOM } = jsdom;

/* Grab all the <figcaptions> from tables and add a figure_link in the table-wrap div */
const table_dropdowns = (html) => {
  const dom = new JSDOM(`<!DOCTYPE html><body>${html}</body>`);

  const figures = dom.window.document.querySelectorAll('figure');
  [...figures].forEach(figure => {
      const figcaption = figure.querySelector('figcaption');
      if (figcaption) {
        let figure_dropdown = figcaption.innerHTML.replace(/figure_link/, 'figure_dropdown');
        figure_dropdown = figure_dropdown.replace(/caption=".*?"[,\s]*/, '');
        figure_dropdown = figure_dropdown.replace(/caption='.*?'[,\s]*/, '');
        figure_dropdown_node = dom.window.document.createTextNode(figure_dropdown);
        const table_wrap = figure.querySelector('.table-wrap');
        if (figure_dropdown && table_wrap) {
          table_wrap.appendChild(figure_dropdown_node);
        }
      }
  });

  return dom.window.document.querySelector('body').innerHTML;
};

module.exports = {
  table_dropdowns
};
