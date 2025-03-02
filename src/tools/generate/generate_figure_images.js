const fs = require('fs-extra');
const puppeteer = require('puppeteer');

const { find_markdown_files } = require('./shared');

const take_single_screenshot = async (graphUrl, filename) => {

  const sheets_chart = graphUrl.startsWith('https://docs.google.com/spreadsheets') ? true :  false;

  const chartUrl = sheets_chart ? graphUrl : 'http://localhost:8080/' + graphUrl;
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.setViewport({
    "width": 1280,
    "height": 800,
    "deviceScaleFactor": 2
  });
  await page.goto(chartUrl, {
    waitUntil: 'networkidle2',
  });


  // Charts are in #embed_chart, maps are in #c div div
  const el = sheets_chart ? await page.$('#embed_chart, #c div div') : await page.$('main');
  await el.screenshot({ path: filename });
  await browser.close();
}

const generate_images = async (chapter_match) => {

  // This next bit is taken from generate_chapters.js, but only allow it to match one chapter
  if (chapter_match) {
    // Remove any trailing .md and replace all paths with brackets to capture components
    // en/2019/javascript.md -> (en)/(2019)/(javascript).md
    chapter_match = chapter_match.replace(/\.md$/,'');
    chapter_match = chapter_match.replace(/^content[\/\\]*/,'');
    chapter_match = (process.platform != 'win32')
                ? 'content\/' +  '(' + chapter_match.replace(/\//g,')/(') + ').md'
                : 'content\\\\' +  '(' + chapter_match.replace(/\//g,')\\\\(') + ').md';

    new RegExp(chapter_match);
  } else {
    console.log('Please provide an argument of the form: en/2020/performance');
    process.exit(1);
  }

  for (const file of await find_markdown_files()) {

    let path, language, year, chapter;

    try {
      [path, language, year, chapter] = file.match(re);
    } catch(error) {
      // No match - skip to next in for loop
      continue;
    }

    if (language !== "en") {
      console.log("Skipping non-English chapter");
      continue;
    }

    console.log(`Generating for the ${year} ${chapter} chapter:`);

    const markdown = await fs.readFile(file, 'utf-8');

    // Let's not depend on the order of arguments:
    const figure_regexp = /{{[\s]*figure_markup\([^}]*(image|chart_url)=["']([^'"]*)["'][^}]*(image|chart_url)=["']([^'"]*)["'][^}]*\)[^}]*}}/g;

    const matches = markdown.matchAll(figure_regexp);

    const path_separator = (process.platform != 'win32') ? '/' : '\\';

    // Check if the year directory exists and, if not, create it
    let folder_path = `static${path_separator}images${path_separator}${year}`;
    if (!fs.existsSync(folder_path)) {
      console.log(`  Creating directory: ${folder_path}`);
      fs.mkdirSync(folder_path);
    }

    // Check if the chapter directory exists and, if not, create it
    folder_path = `${folder_path}${path_separator}${chapter}`;
    if (!fs.existsSync(folder_path)) {
      console.log(`  Creating directory: ${folder_path}`);
      fs.mkdirSync(folder_path);
    }

    for (const match of matches) {

      const image_file = (match[1] === 'image') ? match[2] : match[4];
      const chart_url = (match[1] === 'image') ? match[4] : match[2];

      // Test for blank image (not set yet), or an image which is from another location
      if (!image_file || image_file.startsWith('/') || image_file.startsWith('..') || image_file.startsWith('http:') || image_file.startsWith('https:')) {
        console.log(`  Skipping: ${image_file} as not a chapter image`);
        continue;
      }

      // Test chart_url is a Google Sheets URL
      if (!(
        (chart_url.startsWith('https://docs.google.com/spreadsheets') && chart_url.endsWith('&format=interactive'))
        ||
        (chart_url.startsWith('/') && chart_url.indexOf('/embeds/'))
      )) {
        console.log(`  Skipping: ${image_file} as chart_url is not of the correct format`);
        continue;
      }

      // Check if the image already exists
      const file_path = `${folder_path}${path_separator}${image_file}`;
      if (fs.existsSync(file_path)) {
        console.log(`  Skipping: ${image_file} as image already exists`);
        continue;
      }

      console.log(`  Generating image ${image_file}...`);
      await take_single_screenshot(chart_url, file_path);
    }
  }

  console.log('All done!');
}

(async () => {
  try {
    const first_arg = process.argv.slice(2)[0];
    await generate_images(first_arg);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
})();
