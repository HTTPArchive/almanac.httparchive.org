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

const find_files = async () => {
  const filter = (file, stats) => {
    const isMd = file && file.endsWith('.md');
    const isDirectory = stats && stats.isDirectory();

    return !isMd && !isDirectory;
  };

  return await recursive('content', [filter]);
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
  find_files,
  find_template_files,
  size_of,
  parse_array
};
