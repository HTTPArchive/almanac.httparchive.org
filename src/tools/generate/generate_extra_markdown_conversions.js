const { convertSimpleMarkdown } = require('./shared');

// Allow markdown to be used within HTML tags by doing an extra conversion there
const generate_extra_markdown_conversions = (body) => {
  // Convert any markdown in table figure_links
  body = body.replace(/(\{\{ figure_link\([^}]*caption=")(.*?[^\\])(")/g, function(a, b, c, d) { return b + convertSimpleMarkdown(c) + d});
  body = body.replace(/(\{\{ figure_link\([^}]*caption=')(.*?[^\\])(')/g, function(a, b, c, d) { return b + convertSimpleMarkdown(c) + d});

  // Convert any markdown in table cells
  body = body.replace(/(<th[^>]*>)(.*?)(<\/th>)/g, function(a, b, c, d) { return b + convertSimpleMarkdown(c) + d});
  body = body.replace(/(<td[^>]*>)(.*?)(<\/td>)/g, function(a, b, c, d) { return b + convertSimpleMarkdown(c) + d});

  // Convert any markdown in Notes and BlockQuotes>
  body = body.replace(/(<p class="note">)(.*?)(<\/p>)/gs, function(a, b, c, d) { return b + convertSimpleMarkdown(c) + d});
  body = body.replace(/(<blockquote>)(.*?)(<\/blockquote>)/gs, function(a, b, c, d) { return b + convertSimpleMarkdown(c) + d});

  return body;
}

module.exports = {
  generate_extra_markdown_conversions
};
