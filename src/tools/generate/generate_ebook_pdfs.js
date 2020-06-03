const fs = require('fs-extra');
const { exec } = require("child_process");

const { find_config_files } = require('./shared');

const generate_ebook_pdfs = async () => {

  let configs = {};
  let ebook_languages = {};

  // Read all the config files
  for (const config_file of await find_config_files()) {
    const re = (process.platform != 'win32') 
                  ? /config\/([0-9]*).json/ 
                  : /config\\([0-9]*).json/;
    const [path,year] = config_file.match(re);
    
    configs[year] = JSON.parse(await fs.readFile(`config/${year}.json`, 'utf8'));
    ebook_languages[year] = configs[year].settings[0].ebook_languages

  }

  //Generate all the configured ebook pdfs
  for(let year in ebook_languages) {
    console.log('Ebooks configured for',year, ':',ebook_languages[year]);
    ebook_languages[year].forEach((language) => {
      console.log('Generating ebook for',year,language);
      const command = `prince http://127.0.0.1:8080/${language}/${year}/ebook?print -o static/pdfs/web_almanac_${year}_${language}.pdf --pdf-profile='PDF/UA-1'`;
      exec (command, (err, stdout, stderr) => {
        if (err) {
          //some err occurred
          console.error(err)
        } else {
        // the *entire* stdout and stderr (buffered)
        console.log(`stdout: ${stdout}`);
        console.log(`stderr: ${stderr}`);
        }
      });
    });
  }
};

(async () => {
  // Can uncomment this to get latest timestamps from origin:master
  // let { generate_last_updated } = require('./generate_last_updated');
  // await generate_last_updated();

  await generate_ebook_pdfs();
})();
