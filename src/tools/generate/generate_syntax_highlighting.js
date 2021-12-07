const { JSDOM } = require('jsdom');
const rainbow = require('rainbow-code');


/**
 * Generate Syntax highlighting for a particular Languaage (ex: html, css, javascript etc..)
 *
 * @param {object} dom Object of class JSDOM (Parsed HTML).
 * @param {String} body HTML body parsed from convertor
 * @param {String} language language which rainbow syntax highlighting to use
 * @param {String} [alias] an optional alias for a language (e.g. js for javascript)
 * @returns body with highlighting syntax snippet of a particular language.
 */
const generate_syntax_highlighting_for_language = (dom, body, language, alias="") => {
  const query_selector = alias ? `code.language-${language}, code.language-${alias}` : `code.language-${language}`;
  const code_snippets = dom.window.document.querySelectorAll(query_selector);
  code_snippets.forEach(element => {
    const snippet_clean = element.innerHTML.replace(/&lt;/g, '<').replace(/&gt;/g, '>');
    const snippet_converted = rainbow.colorSync(snippet_clean, language);
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
  body = generate_syntax_highlighting_for_language(dom, body, "html");
  body = generate_syntax_highlighting_for_language(dom, body, "css" );
  body = generate_syntax_highlighting_for_language(dom, body, "javascript", "js");
  body = generate_syntax_highlighting_for_language(dom, body, "json");
  body = generate_syntax_highlighting_for_language(dom, body, "sql");
  return body;
};

module.exports = {
  generate_syntax_highlighting
};
