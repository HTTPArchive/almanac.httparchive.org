const generate_header_links = (html) => {
  const header_regex = /<h([2-6]) id="(.*?)"(.*?)>(.*?)<\/h[2-6]>/gi;
  return html.replace(header_regex, '<h$1 id="$2"$3><a href="#$2" class="anchor-link">$4</a></h$1>');
};

module.exports = {
  generate_header_links
};
  