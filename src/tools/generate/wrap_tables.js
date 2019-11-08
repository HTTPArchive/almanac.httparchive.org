const jsdom = require("jsdom");
const { JSDOM } = jsdom;

const wrap_tables = (html) => {
  const dom = new JSDOM(`<!DOCTYPE html><body>${html}</body>`);

  const tables = dom.window.document.querySelectorAll('table');
  [...tables].forEach(table => {
      const wrapper = dom.window.document.createElement('div');
      wrapper.className = 'table-wrap';

      const container = dom.window.document.createElement('div');
      container.className = 'table-wrap-container';

      table.parentNode.insertBefore(container, table);
      container.appendChild(table);

      container.parentNode.insertBefore(wrapper, container);
      wrapper.appendChild(container);
  });

  return dom.window.document.querySelector('body').innerHTML;
};

module.exports = {
  wrap_tables
};
