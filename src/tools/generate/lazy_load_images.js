const lazy_load_images = (html) => {
  const re = /<img\s/gi;

  return html.replace(re, () => `<img loading="lazy"`);
};

module.exports = {
  lazy_load_images
};
