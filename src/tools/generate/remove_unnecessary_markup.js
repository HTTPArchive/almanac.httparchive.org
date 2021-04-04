/* 
  TODO: This is a workaround for the unnecessary markup that's being generated 
  by JSDOM. Once that has been fixed, this can hopefully be removed. 
  (See #412) 
*/
const remove_unnecessary_markup = (html) => {
  // Remove pointless paragraph tags added by JSON in wrap_tables
  html = html.replace(/<p><\/p>/g, '');
  // Remove pointless paragraph tags added around Jinja figure calls
  html = html.replace(/\n*<p>({{ figure_markup.*?)<\/p>\n*/gis, '$1');
  return html
}

module.exports = {
  remove_unnecessary_markup
};
