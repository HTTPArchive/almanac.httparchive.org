const { JSDOM } = require('jsdom');

const getElementContents = (dom,selector) => {
  if (dom.window.document.querySelector(selector)) {
    let contents = dom.window.document.querySelector(selector).innerHTML;
    // Fix some double escapes:
    contents = contents.replace(/&amp;([a-z]+);/g,'&$1;');
    return contents;
  }
}

const generate_chapter_featured_quote = (body) => {
  const dom = new JSDOM(body);
  const featured_quote = getElementContents(dom, '#featured-quote');
  const featured_stat_1 = getElementContents(dom,'#featured-stat-1');
  const featured_stat_label_1 = getElementContents(dom,'#featured-stat-label-1');
  const featured_stat_2 = getElementContents(dom,'#featured-stat-2');
  const featured_stat_label_2 = getElementContents(dom,'#featured-stat-label-2');
  const featured_stat_3 = getElementContents(dom,'#featured-stat-3');
  const featured_stat_label_3 = getElementContents(dom,'#featured-stat-label-3');

  let featured_quote_obj = {};
  if (featured_quote) {
    featured_quote_obj.quote = featured_quote;
  }
  if (featured_stat_1 && featured_stat_label_1) {
    featured_quote_obj.stat_1 = featured_stat_1;
    featured_quote_obj.stat_label_1 = featured_stat_label_1;
  }
  if (featured_stat_2 && featured_stat_label_2) {
    featured_quote_obj.stat_2 = featured_stat_2;
    featured_quote_obj.stat_label_2 = featured_stat_label_2;
  }
  if (featured_stat_3 && featured_stat_label_3) {
    featured_quote_obj.stat_3 = featured_stat_3;
    featured_quote_obj.stat_label_3 = featured_stat_label_3;
  }

  return featured_quote_obj;
};

module.exports = {
  generate_chapter_featured_quote
};
