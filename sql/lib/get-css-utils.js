const fs = require("fs");
const https = require("https");

function readFile(file, enc = "utf8") { // eslint-disable-line no-unused-vars
  return new Promise((resolve, reject) => {
    fs.readFile(file, enc, (err,data) => {
      if (err) {
        reject(err);
      }

      resolve(data);
    });
  });
}

function writeFile(file, contents, enc) {
  return new Promise((resolve, reject) => {
    fs.writeFile(file, contents, enc, (err) => {
      if (err) {
        reject(err);
      }

      resolve();
    });
  });
}

function downloadFile(url) {
  return new Promise((resolve, reject) => {
    let data = "";
    let request = https.get(url, response => {
      response.on("data", chunk => data += chunk);
      response.on("end", () => resolve(data));
    });

    request.on("error", err => {
      reject(err);
    });
  })

}

const urls = [
  "https://projects.verou.me/parsel/parsel_nomodule.js",
  "https://projects.verou.me/rework-utils/rework-utils.js"
];

(async ()=>{

  let contents = urls.map(async url => await downloadFile(url));

  contents = await Promise.all(contents);

  contents = contents.join("\n\n");

  writeFile("./css-utils.js", contents);

})();
