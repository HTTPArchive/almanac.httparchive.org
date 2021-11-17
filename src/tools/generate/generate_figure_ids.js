const generate_figure_ids = (html) => {

  let figure_count = 0;

  // Add metadata and _figid_ placeholders to figure_markups
  let re = /figure_markup\s*\(/g;
  html = html.replace(re, () => 'figure_markup(metadata=metadata, chapter_config=chapter_config, id=_figid_, ');

  // Add handle tables which don't use figure_markups
  // Need to add id in <figure> element at top of table
  // and also in figure_link call from <figcaption> element
  // at bottom of table.
  re = /(<figure>|<figure markdown>|<figure data-markdown="1">)\s*\n*\s*<table/gi;
  html = html.replace(re, () => '<figure id="fig-_figid_"><table');
  re = /figure_link\s*\(/g;
  html = html.replace(re, () => 'figure_link(metadata=metadata, chapter_config=chapter_config, id=_figidn_, ');

  // replace _figid_ with i and increment
  // replace _figidn_ with i and do not increment
  re = /_figid(n?)_/g;
  html = html.replace(re, ($1, $2) => {
    if ($2) {
      return figure_count;
    } else {
      return ++figure_count;
    }
  });

  return html;
};

module.exports = {
  generate_figure_ids
};
