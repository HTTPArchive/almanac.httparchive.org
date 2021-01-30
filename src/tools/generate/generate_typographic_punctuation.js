const smartypants = require('smartypants');

const generate_typographic_punctuation = (body) => {

  // Temporarily comment out any Jinja macros to avoid them being converted
  // as smartypants doesn't recognise those parameters as
  body = body.replace(/\{\{/g,'<!--<jinja-macro{{');
  body = body.replace(/\}\}/g,'}}></jinja-macro>-->');
  // However do want descriptions and captions, so uncomment those arguments
  body = body.replace(/(\{\{[^}]*description=")(.*?[^\\])(")/g,'$1<jinja-arg>-->$2<!--</jinja-arg>$3');
  body = body.replace(/(\{\{[^}]*caption=")(.*?[^\\])(")/g,'$1<jinja-arg>-->$2<!--</jinja-arg>$3');
  body = body.replace(/(\{\{[^}]*description=')(.*?[^\\])(')/g,'$1<jinja-arg>-->$2<!--</jinja-arg>$3');
  body = body.replace(/(\{\{[^}]*caption=')(.*?[^\\])(')/g,'$1<jinja-arg>-->$2<!--</jinja-arg>$3');

  // Now do the actual conversion
  body = smartypants.smartypants(body);

  // Uncomment Jinja functions
  body = body.replace(/<!--<jinja-macro/g,'');
  body = body.replace(/><\/jinja-macro>-->/g,'');
  body = body.replace(/<jinja-arg>-->/g,'');
  body = body.replace(/<!--<\/jinja-arg>/g,'');

  return body;
};

const generate_typographic_punctuation_metadata = (metadata) => {

  for (item in metadata) {
    metadata[item] = smartypants.smartypants(metadata[item]);
  }
  /*
  metadata.featured_quote = smartypants.smartypants(metadata.featured_quote);
  metadata.featured_stat_label_1 = smartypants.smartypants(metadata.featured_stat_label_1);
  metadata.featured_stat_label_2 = smartypants.smartypants(metadata.featured_stat_label_2);
  metadata.featured_stat_label_3 = smartypants.smartypants(metadata.featured_stat_label_3);
  */

  return metadata;
}

module.exports = {
  generate_typographic_punctuation,
  generate_typographic_punctuation_metadata
};
