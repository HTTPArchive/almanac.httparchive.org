#standardSQL
# Top JS frameworks and libraries by version
SELECT
  _TABLE_SUFFIX AS client,
  category,
  app,
  info AS version,
  COUNT(DISTINCT url) AS pages,
  total,
  COUNT(DISTINCT url) / total AS pct
FROM
  `httparchive.technologies.2024_06_01_*`
JOIN (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2024_06_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (_TABLE_SUFFIX)
WHERE
  app IN ('jQuery', 'jQuery Migrate', 'jQuery UI', 'Modernizr', 'FancyBox', 'Slick', 'Lightbox', 'Moment.js', 'Underscore.js', 'Lodash', 'React', 'GSAP', 'Vue.js', 'styled-components', 'Emotion', 'Backbone.js', 'RequireJS', 'AngularJS', 'AMP', 'Redux', 'Next.js', 'Stimulus', 'Angular', 'Handlebars', 'Zone.js', 'Marionette.js', 'Mustache', 'Prototype', 'toastr', 'JSS', 'React Router', 'Nuxt.js', 'Alpine.js', 'Svelte', 'MooTools', 'Knockout.js', 'Socket.io', 'Gatsby', 'Adobe Client Data Layer')
GROUP BY
  client,
  category,
  app,
  info,
  total
ORDER BY
  pct DESC
