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
    const [path, year] = config_file.match(re); // eslint-disable-line no-unused-vars

    configs[year] = JSON.parse(await fs.readFile(`config/${year}.json`, 'utf8'));
    ebook_languages[year] = configs[year].settings[0].ebook_languages

  }

  // Generate all the configured ebook pdfs
  for(let year in ebook_languages) {
    console.log('Ebooks configured for',year, ':',ebook_languages[year]);
    ebook_languages[year].forEach((language) => {

      // Generate Ebook PDF
      console.log('Generating ebook for',year,language);
      const command = `prince "http://127.0.0.1:8080/${language}/${year}/ebook?print" -o static/pdfs/web_almanac_${year}_${language}.pdf --pdf-profile="PDF/UA-1"`;
      exec (command, (err, stdout, stderr) => {
        if (err) {
          // some err occurred
          console.error(err)
        } else {
          // the *entire* stdout and stderr (buffered)
          console.log(`stdout: ${stdout}`);
          console.log(`stderr: ${stderr}`);
        }
      });

      let move = "mv";
      if (process.platform === 'win32') {
        move = "move";
      }

      // Generate Printer Ebook PDF
      const printer_pdf_file = 'static/pdfs/web_almanac_' + year + '_' + language + '_print_A5.pdf';
      const printer_command = `prince "http://127.0.0.1:8080/${language}/${year}/ebook?print&printer" -o ${printer_pdf_file}`;
      exec (printer_command, (err, stdout, stderr) => {
        if (err) {
          // some err occurred
          console.error(err)
        } else {
          // the *entire* stdout and stderr (buffered)
          console.log(`stdout: ${stdout}`);
          console.log(`stderr: ${stderr}`);
        }
      });

      // Generate Printer Cover PDF
      const cover_pdf_file = 'static/pdfs/web_almanac_' + year + '_' + language + '_cover_A5.pdf';
      const cover_command = `prince "http://127.0.0.1:8080/${language}/${year}/ebook?cover" -o ${cover_pdf_file}`;
      exec (cover_command, (err, stdout, stderr) => {
        if (err) {
          // some err occurred
          console.error(err)
        } else {
          // the *entire* stdout and stderr (buffered)
          console.log(`stdout: ${stdout}`);
          console.log(`stderr: ${stderr}`);
          const remove_cover_pages = `pdftk ${cover_pdf_file} cat 2-end output ${cover_pdf_file}.tmp && ${move} ${cover_pdf_file}.tmp ${cover_pdf_file}`;
          exec (remove_cover_pages, (err, stdout, stderr) => {
            if (err) {
              // some err occurred
              console.error(err)
            } else {
              // the *entire* stdout and stderr (buffered)
              console.log(`stdout: ${stdout}`);
              console.log(`stderr: ${stderr}`);
            }
          });
        }
      });
    });
  }
};

(async () => {
  try {
    await generate_ebook_pdfs();
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
})();
