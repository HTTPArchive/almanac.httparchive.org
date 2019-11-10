/* 
  TODO: This is a workaround for the unnecessary markup that's being generated 
  by JSDOM. Once that has been fixed, this can hopefully be removed. 
  (See #412) 
*/
const remove_unnecessary_markup = (html) => html.replace(/<p><\/p>/g, '');

module.exports = {
  remove_unnecessary_markup
};
