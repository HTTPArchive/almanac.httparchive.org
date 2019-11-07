// This regex is very aggressive, and may include images that are inside `pre`  tags.
const all_images_regex = /<img\s/gi;

// This regex only matches images inside `figure` tags.
const images_inside_figures = /<figure(?: [^<>]+)?>(?:(?:(?!<figure).)*)(<img)(?:(?:(?!<figure).)*)<\/figure>/gis;

const lazy_load_images = (html) => {
  return html.replace(images_inside_figures, `<img loading="lazy"`);
};

module.exports = {
  lazy_load_images
};
