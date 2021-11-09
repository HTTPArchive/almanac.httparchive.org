const smartypants = require('smartypants');

const generate_typographic_punctuation_body = (body) => {

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
  // Avoid -- to em-dash conversion - see #2445
  body = smartypants.smartypants(body, 'qBe');

  // Uncomment Jinja functions
  body = body.replace(/<!--<jinja-macro/g,'');
  body = body.replace(/><\/jinja-macro>-->/g,'');
  body = body.replace(/<jinja-arg>-->/g,'');
  body = body.replace(/<!--<\/jinja-arg>/g,'');

  return body;
};

const generate_typographic_punctuation_metadata = (metadata) => {

  for (const item in metadata) {
    // Double quotes are handled in the meta data by changing to &quot;
    // Temporarily change them back so we can typograph the ones that need it
    metadata[item] = metadata[item].replace(/&quot;/g, '"');
    metadata[item] = smartypants.smartypants(metadata[item]);
    metadata[item] = metadata[item].replace(/"/g, '&quot;');
  }

  return metadata;
}

module.exports = {
  generate_typographic_punctuation_body,
  generate_typographic_punctuation_metadata
};
