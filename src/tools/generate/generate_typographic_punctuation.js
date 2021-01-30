const smartypants = require('smartypants');

const generate_typographic_punctuation = (html) => {

  // Temporarily comment out any Jinja macros to avoid them being converted
  // as smartypants doesn't recognise those parameters as
  html = html.replace(/\{\{/g,'<!--<jinja-macro{{');
  html = html.replace(/\}\}/g,'}}></jinja-macro>-->');
  // However do want descriptions and captions, so uncomment those arguments
  html = html.replace(/(\{\{[^}]*description=")(.*?[^\\])(")/g,'$1<jinja-arg>-->$2<!--</jinja-arg>$3');
  html = html.replace(/(\{\{[^}]*caption=")(.*?[^\\])(")/g,'$1<jinja-arg>-->$2<!--</jinja-arg>$3');
  html = html.replace(/(\{\{[^}]*description=')(.*?[^\\])(')/g,'$1<jinja-arg>-->$2<!--</jinja-arg>$3');
  html = html.replace(/(\{\{[^}]*caption=')(.*?[^\\])(')/g,'$1<jinja-arg>-->$2<!--</jinja-arg>$3');
  html = smartypants.smartypants(html);

  // Uncomment Jinja functions
  html = html.replace(/<!--<jinja-macro/g,'');
  html = html.replace(/><\/jinja-macro>-->/g,'');
  html = html.replace(/<jinja-arg>-->/g,'');
  html = html.replace(/<!--<\/jinja-arg>/g,'');

  return html;
};

module.exports = {
  generate_typographic_punctuation
};
