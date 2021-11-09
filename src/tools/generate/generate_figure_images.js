const fs = require('fs-extra');
const puppeteer = require('puppeteer');

const { find_markdown_files } = require('./shared');

const take_single_screenshot = async (graphUrl, filename) => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.setViewport({
    "width": 1280,
    "height": 800,
    "deviceScaleFactor": 2
  });
  await page.goto(graphUrl, {
    waitUntil: 'networkidle2',
  });
  const el = await page.$('#embed_chart');
  await el.screenshot({ path: filename });
  await browser.close();
}

const generate_images = async (chapter_match) => {

  if (chapter_match) {
    // Remove any trailing .md and replace all paths with brackets to capture components
    // en/2019/javascript.md -> (en)/(2019)/(javascript).md
    chapter_match = chapter_match.replace(/\.md$/,'');
    chapter_match = chapter_match.replace(/^content[\/\\]*/,'');
    chapter_match = (process.platform != 'win32')
                ? 'content\/' +  '(' + chapter_match.replace(/\//g,')/(') + ').md'
                : 'content\\\\' +  '(' + chapter_match.replace(/\\/g,')\\\\(') + ').md';
    re = new RegExp(chapter_match);
  } else {
    console.log('Please provide an argument of the form: en/2020/performance')
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

    console.log(`Generating for chapter: ${chapter} for year ${year}`)

    const markdown = await fs.readFile(file, 'utf-8');

    // Let's not depend on the order of arguments to test for both
    const figure_regexp1 = /{{ figure_markup\([^}]*image=["']([^'"]*)["'][^}]*chart_url=["']([^'"]*)["'][^}]*\)[^}]*}}/g;
    const figure_regexp2 = /{{ figure_markup\([^}]*chart_url=["']([^'"]*)["'][^}]*image=["']([^'"]*)["'][^}]*\)[^}]*}}/g;

    for (const regexp_type of [1, 2]) {

      const figure_regexp = (regexp_type == 1) ? figure_regexp1 : figure_regexp2;

      const matches = markdown.matchAll(figure_regexp);
      for (const match of matches) {

        let image_file = match[1];
        let chart_url = match[2];

        if (figure_regexp == figure_regexp2) {
          image_file = match[2];
          chart_url = match[1];
        }

        if (image_file.startsWith('..') || image_file.startsWith('http')) {
          console.log(`  Skipping: ${image_file} as not a chapter image`);
          continue;
        }

        const file_path = `static/images/${year}/${chapter}/${image_file}`;

        if (fs.existsSync(file_path)) {
          console.log(`  Skipping: ${image_file} as image already exists`);
          continue;
        }

        console.log(`  Generating image ${image_file}...`);
        await take_single_screenshot(chart_url, file_path);
      }
    }
  }
}



(async () => {
  try {
    const first_arg = process.argv.slice(2)[0]
    await generate_images(first_arg);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
})();


