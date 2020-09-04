const generate_figure_ids = (html, figure_lock) => {

  let figure_count = 0;

  if (html.includes('figure_markup(')) {
    // New style figure markup

    // Add metadata and _figid_ placeholders to figure_markups
    let re = /figure_markup\s*\(/g;
    html = html.replace(re, () => 'figure_markup(metadata=metadata, id=_figid_, ');

    // Add handle tables which don't use figure_markups
    // Need to add id in <figure> element at top of table
    // and also in figure_link call from <figcaption> element
    // at bottom of table.
    re = /<figure>|<figure markdown>|<figure data-markdown="1">/gi;
    html = html.replace(re, () => '<figure id="fig-_figidn_">');
    re = /figure_link\s*\(/g;
    html = html.replace(re, () => 'figure_link(metadata=metadata, id=_figid_, ');

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

  } else {
    // Old style figure markup - can remove after all chapters converted

    const re = /<figure>|<figure markdown>|<figure data-markdown="1">/gi;

    html = html.replace(re, () => `<figure id='fig-${++figure_count}'>`);

    //Add the show description button
    html = html.replace(/<div id="fig([0-9]+)-description"/gi, '<button hidden class="fig-description-button" aria-expanded="false" aria-controls="fig$1-description" data-show-text="{{ show_description(metadata=metadata, id=$1) }}" data-hide-text="{{ hide_description(metadata=metadata, id=$1) }}">{{ show_description(metadata=metadata, id=$1) }}</button><div id="fig$1-description"');

    //Some of our 2019 chapters (markdown and performance) had different fig ids
    const figcaption_regex = /<figcaption(.*?)>(.*?)([0-9]+)\./gi;
    if (html.includes('<figure id="fig1"')) {
      html = html.replace(figcaption_regex, '<figcaption$1><a href="#fig$3" class="anchor-link">$2 $3.</a>');
    } else {
      html = html.replace(figcaption_regex, '<figcaption$1><a href="#fig-$3" class="anchor-link">$2 $3.</a>');
    }
  }

  // After a chapter is published a figure_lock value should be set
  // So check the figure count hasn't changed
  if (figure_lock && figure_lock != figure_count) {
    console.error("Total figures have changed from: ", figure_lock, " to: ", figure_count);
    console.error("After publishing we strongly advise NOT to change figure numbering.");
    console.error("Adding new figures is usually OK but update the figure_lock count.");
    console.error("If removing, perhaps consider commenting out figures instead,");
    console.error("to ensure consistency in figure numbering");
    throw("Total figures have changed from: ", figure_lock, " to: ", figure_count);
  }

  return html;
};

module.exports = {
  generate_figure_ids
};
