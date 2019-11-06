const jsdom = require("jsdom");
const { JSDOM } = jsdom;

const wrap_tables = (html) => {
  const dom = new JSDOM(`<!DOCTYPE html><body>${html}</body>`);

  const tables = dom.window.document.querySelectorAll('table');
  [...tables].forEach(table => {
      const wrapper = dom.window.document.createElement('div');
      wrapper.className = 'table-wrap';

      table.parentNode.insertBefore(wrapper, table);
      wrapper.appendChild(table);
  });

  return dom.window.document.querySelector('body').innerHTML;
};

module.exports = {
  wrap_tables
};
