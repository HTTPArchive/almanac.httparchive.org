const fs = require('fs-extra');
const recursive = require('recursive-readdir');

const find_template_files = async () => {
  const filter = (file, stats) => {
    const isHtml = file && file.endsWith('.html');
    const isDirectory = stats && stats.isDirectory();

    return !isHtml && !isDirectory;
  };

  return await recursive('templates', [filter]);
};

const find_markdown_files = async () => {
  const filter = (file, stats) => {
    const isMd = file && file.endsWith('.md');
    const isDirectory = stats && stats.isDirectory();

    return !isMd && !isDirectory;
  };

  return await recursive('content', [filter]);
};

const find_config_files = async () => {
  const filter = (file, stats) => {
    const isJSON = file && file.endsWith('.json')

    return !isJSON;
  };

  return await recursive('config', [filter]);
};

const get_yearly_configs = async () => {

  let configs = {};

  for (const config_file of await find_config_files()) {
    const re = (process.platform != 'win32') 
                  ? /config\/([0-9]*).json/ 
                  : /config\\([0-9]*).json/;
    const [path,year] = config_file.match(re);
    
    configs[year] = JSON.parse(await fs.readFile(`config/${year}.json`, 'utf8'));
  }
  return configs;
};

const size_of = async (path) => {
  let b = (await fs.stat(path)).size;

  let u = 0,
    s = 1024;
  while (b >= s || -b >= s) {
    b /= s;
    u++;
  }
  let size = (u ? b.toFixed(1) + ' ' : b) + ' KMGTPEZY'[u] + 'B';

  console.log(` - Output file size: ${size}`);
};

const parse_array = (array_as_string) => {
  return (array_as_string == "[]" ? null : array_as_string
    .substring(1, array_as_string.length - 1)
    .split(',')
    .map((value) => value.trim()));
};

module.exports = {
  find_markdown_files,
  find_template_files,
  find_config_files,
  get_yearly_configs,
  size_of,
  parse_array
};
