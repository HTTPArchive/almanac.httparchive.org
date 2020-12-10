const fs = require("fs-extra");
const fetch = require("node-fetch");
const convert = require('xml-js');

const { get_yearly_configs } = require('../generate/shared');

const default_year = 2020;
const default_language = 'en';
const base_url = "http://127.0.0.1:8080";

const output_dir = `static/html`;

let failures = 0;
let passes = 0;

let configs = {};
let languages = {};
let ebooks = {};

const get_config = async () => {

  configs = await get_yearly_configs();
  for (const year in configs) {
    languages[year] = configs[year].settings[0].supported_languages;
    ebooks[year] = configs[year].settings[0].ebook_languages;
  }
};

const test_status_code = async (page, status, location) => {

  if (location == undefined) {
    location = null;
  } else {
    location = base_url + location;
  }

  try {

    // Don't follow redirects
    const options = {
      redirect: 'manual'
    };

    const response = await fetch(base_url + page, options);

    if (response.status === status && response.headers.get('location') === location) {
      //console.log('Success - expected:', status, 'got:',response.status, 'for page:', page);
      passes++;
      if (status === 200 && response.headers.get('content-type').startsWith('text/html')) {
        if (page.slice(-1) === '/') page = page + 'index';
        page = page + '.html';
        const body = await response.text();
        await fs.outputFile(output_dir + page, body, 'utf8');
      }
    } else {
      console.error('Failed - expected:', status, 'got:', response.status, 'for page:', page, 'location:', location);
      failures++;
    }

  } catch (error) {
    console.error('Error - expected:', status, 'for page:', page);
    console.log(error);
    failures++;
  }
};

const test_sitemap_pages = async () => {
  const xml = await fs.readFile(`templates/sitemap.xml`, 'utf-8');
  const sitemap = JSON.parse(convert.xml2json(xml, {compact: true}));
  const urls = sitemap['urlset']['url'];
  for ( var url in urls ) {
    let page = urls[url]['loc']['_text'].trim();
    page = page.replace('https://almanac.httparchive.org', '');
    await test_status_code(page, 200);
  }
}

const test_ebooks = async () => {
  for (const year in ebooks) {
    for (const language in ebooks[year]) {
      await test_status_code(`/${ebooks[year][language]}/${year}/ebook`, 200);
    }
  }
}

const test_404_pages = async () => {
  for (const year in languages) {
    for (const language in languages[year]) {
      await test_status_code(`/${languages[year][language]}/${year}/random`, 404);
    }
  }
}

const test_no_year_redirects = async () => {
  for (const year in languages) {
    for (const language in languages[year]) {
      await test_status_code(`/${languages[year][language]}/`, 302, `/${languages[year][language]}/${default_year}/`);
    }
  }
}

const test_status_codes = async () => {

  await get_config();

  // Test success pages
  await test_sitemap_pages();
  await test_ebooks();
  await test_status_code('/sitemap.xml', 200);
  await test_status_code('/robots.txt', 200);
  await test_status_code('/favicon.ico', 200);

  // Test Redirects
  await test_status_code('/', 302, `/${default_language}/${default_year}/`);
  await test_no_year_redirects();
  await test_status_code('/zz', 308, `/zz/`);
  await test_status_code('/zh/', 302, `/zh-CN/`);
  await test_status_code('/zh-HANT/', 302, `/zh-TW/`);
  await test_status_code('/zh-CHT/', 302, `/zh-TW/`);
  await test_status_code('/zh-hans/', 302, `/zh-CN/`);
  await test_status_code('/en-GB/', 302, `/en/`);
  await test_status_code('/EN/', 302, `/en/`);

  //Test 404s
  await test_404_pages();
  await test_status_code('/zz/', 404);
  await test_status_code('/zz/2018/', 404);
  await test_status_code('/en/2018/', 404);
  await test_status_code('/base/', 404);
  await test_status_code('/base/methodology', 308, `/base/methodology/`);
  await test_status_code('/base/methodology/', 404);
  await test_status_code('/base/2019/methodology/', 404);

  console.log('Passes:', passes, "Failures:", failures);
  process.exitCode = failures;

}

module.exports = {
    test_status_codes
};
