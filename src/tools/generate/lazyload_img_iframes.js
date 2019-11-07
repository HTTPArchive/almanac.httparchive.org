const jsdom = require("jsdom");
const { JSDOM } = jsdom;

const lazyload_img_iframes = (html) => {
  const dom = new JSDOM(`<!DOCTYPE html><body>${html}</body>`);

  const els = dom.window.document.querySelectorAll('iframe, img');
  [...els].forEach(el => {
      el.setAttribute('loading', 'lazy');
  });

  return dom.window.document.querySelector('body').innerHTML;
};

module.exports = {
  lazyload_img_iframes
};
