const { JSDOM } = require('jsdom');

const lazy_load_content = (html) => {
  const dom = new JSDOM(html);
  
  var all_fig_iframes = dom.window.document.querySelectorAll('figure iframe');
  all_fig_iframes.forEach(function(fig_iframe) {
    fig_iframe.setAttribute('loading','lazy')
  });
  
  var all_fig_img = dom.window.document.querySelectorAll('figure img');
  all_fig_img.forEach(function(fig_img) {
    fig_img.setAttribute('loading','lazy')
  });

  return dom.window.document.querySelector('body').innerHTML;
};


module.exports = {
    lazy_load_content
};