const generate_figure_ids = (html) => {
  const re = /<figure>|<figure markdown>/gi;

  let i = 1;
  return html.replace(re, () => `<figure id='fig-${i++}'>`);
};

module.exports = {
  generate_figure_ids
};
