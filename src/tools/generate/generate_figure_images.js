const puppeteer = require('puppeteer');

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

const generate_images = async (chapter) => {
  console.log("Generating for chapter:", chapter)
  await take_single_screenshot('https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=290736860&format=interactive', 'static/images/2021/privacy/most_common_trackers.png')
  await take_single_screenshot('https://docs.google.com/spreadsheets/d/e/2PACX-1vRfOwcNkLp-mYBkmhDV5AFxl8p0ls9oxFnmmo0WUcAJxjxQqmHjquRZCWj_lNZRyFtX3RdH5T92IESu/pubchart?oid=1126546581&format=interactive', 'static/images/2021/privacy/most_common_tracker_categories.png')
  //...etc.
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


