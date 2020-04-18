const generate_figure_ids = (html) => {
  const re = /<figure>|<figure data-markdown>/gi;

  let i = 1;
  html = html.replace(re, () => `<figure id='fig-${i++}'>`);
  const figcaption_regex = /<figcaption(.*?)>(.*?)([0-9]+)\./gi;
  return html.replace(figcaption_regex, "<figcaption$1><a href=\"#fig-$3\" class=\"anchor-link\">$2 $3.</a>");
};

module.exports = {
  generate_figure_ids
};
