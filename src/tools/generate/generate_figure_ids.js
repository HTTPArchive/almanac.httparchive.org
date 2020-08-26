const generate_figure_ids = (html) => {
  const re = /<figure>|<figure markdown>|<figure data-markdown="1">/gi;

  let i = 1;
  html = html.replace(re, () => `<figure id='fig-${i++}'>`);

  //Add the show description button
  html = html.replace(/<div id="fig([0-9]+)-description"/gi, '<button hidden class="fig-description-button" aria-expanded="false" aria-controls="fig$1-description" data-show-text="{{ show_description(metadata=metadata, id=$1) }}" data-hide-text="{{ hide_description(metadata=metadata, id=$1) }}">{{ show_description(metadata=metadata, id=$1) }}</button><div id="fig$1-description"');

  //Some of our 2019 chapters (markdown and performance) had different fig ids
  const figcaption_regex = /<figcaption(.*?)>(.*?)([0-9]+)\./gi;
  if (html.includes('<figure id="fig1"')) {
    return html.replace(figcaption_regex, '<figcaption$1><a href="#fig$3" class="anchor-link">$2 $3.</a>');
  } else {
    return html.replace(figcaption_regex, '<figcaption$1><a href="#fig-$3" class="anchor-link">$2 $3.</a>');
  }
};

module.exports = {
  generate_figure_ids
};
