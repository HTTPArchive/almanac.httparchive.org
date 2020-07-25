const fs = require('fs-extra');

const { size_of } = require('./shared');

const generate_featured_chapters = async (featured_quotes) => {

  console.log('Generating featured chapters')

  for (let language of Object.keys(featured_quotes)) {

    for (let year of Object.keys(featured_quotes[language])) {
      
      console.log(`\n Generating templates/${language}/${year}/featured_quotes.json`);
      await fs.outputFile(`templates/${language}/${year}/featured_quotes.json`, JSON.stringify(featured_quotes[language][year],null,2), 'utf8');
      await size_of(`templates/${language}/${year}/featured_quotes.json`);

    }
  }

  return true;
};

module.exports = {
  generate_featured_chapters
};
