const { JSDOM } = require('jsdom');
const rainbow = require('rainbow-code');


/**
 * Generate Syntax highlighting for a particular Languaage (ex: html, css, javascript etc..)
 *
 * @param {object} dom Object of class JSDOM (Parsed HTML).
 * @param {String} body HTML body parsed from convertor
 * @param {String} snippet_type snippet type is which type of node to be queried in DOM (like html,css, js, etc. )
 * @param {String} color_rainbow_sync_type string will tell which type of Syntax highlighting shoud be done used for rainbow.colorSync
 * @returns body with highlighting syntax snippet of a particular language.
 */
const generate_syntax_highlighting_for_language = (dom, body, snippet_type, color_rainbow_sync_type) => {
  const code_snippets = dom.window.document.querySelectorAll(`code.language-${snippet_type}`);
  code_snippets.forEach(element => {
    const snippet_clean = element.innerHTML.replace(/&lt;/g, '<').replace(/&gt;/g, '>');
    const snippet_converted = rainbow.colorSync(snippet_clean, color_rainbow_sync_type);
    body = body.replace(element.innerHTML, snippet_converted);
  });
  return body;
};


/**
 * Generate Syntax highlighting for a HTML, CSS, JavaScript and SQL
 *
 * @param {String} body HTML body which was parsed from markdown.
 * @returns body with highlighting syntax snippet.
 */

const generate_syntax_highlighting = (body) => {
  const dom = new JSDOM(body);
  body = generate_syntax_highlighting_for_language(dom, body, "html", "html");
  body = generate_syntax_highlighting_for_language(dom, body, "css", "css");
  body = generate_syntax_highlighting_for_language(dom, body, "js", "javascript");
  body = generate_syntax_highlighting_for_language(dom, body, "sql", "sql");
  return body;
};


module.exports = {
  generate_syntax_highlighting
};
