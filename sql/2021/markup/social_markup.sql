#standardSQL
# social markup popularity

CREATE TEMPORARY FUNCTION getSocialMarkup(payload STRING)
RETURNS STRUCT<
  `og:title` BOOLEAN,
  `og:url` BOOLEAN,
  `og:image` BOOLEAN,
  `og:image:height` BOOLEAN,
  `og:image:width` BOOLEAN,
  `og:type` BOOLEAN,
  `og:description` BOOLEAN,
  `twitter:card` BOOLEAN,
  `twitter:site` BOOLEAN,
  `twitter:title` BOOLEAN,
  `twitter:image` BOOLEAN,
  `twitter:image:alt` BOOLEAN,
  `twitter:description` BOOLEAN
>
LANGUAGE js AS '''
var socialMarkup = [
  "og:title",
  "og:url",
  "og:image",
  "og:image:height",
  "og:image:width",
  "og:type",
  "og:description",
  "twitter:card",
  "twitter:site",
  "twitter:title",
  "twitter:image",
  "twitter:image:alt",
  "twitter:description"
];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return socialMarkup.reduce((results, property) => {
    results[property] = !!almanac['meta-nodes'].nodes.find(meta => meta.property && meta.property.toLowerCase() == property);
    return results;
  }, {});
} catch (e) {
  return socialMarkup.reduce((results, property) => {
    results[property] = false;
    return results;
  }, {});
}
''';

SELECT
  client,
  COUNTIF(socialMarkup.`og:title`) AS og_title,
  COUNTIF(socialMarkup.`og:title`) / COUNT(0) AS pct_og_title,
  COUNTIF(socialMarkup.`og:url`) AS og_url,
  COUNTIF(socialMarkup.`og:url`) / COUNT(0) AS pct_og_url,
  COUNTIF(socialMarkup.`og:image`) AS og_image,
  COUNTIF(socialMarkup.`og:image:height`) / COUNT(0) AS pct_og_image,
  COUNTIF(socialMarkup.`og:image:height`) AS og_image_height,
  COUNTIF(socialMarkup.`og:image:height`) / COUNT(0) AS pct_og_image_height,
  COUNTIF(socialMarkup.`og:image:width`) AS og_image_width,
  COUNTIF(socialMarkup.`og:image:width`) / COUNT(0) AS pct_og_image_width,
  COUNTIF(socialMarkup.`og:type`) AS og_type,
  COUNTIF(socialMarkup.`og:type`) / COUNT(0) AS pct_og_type,
  COUNTIF(socialMarkup.`og:description`) AS og_description,
  COUNTIF(socialMarkup.`og:description`) / COUNT(0) AS pct_og_description,
  COUNTIF(socialMarkup.`twitter:card`) AS twitter_card,
  COUNTIF(socialMarkup.`twitter:card`) / COUNT(0) AS pct_twitter_card,
  COUNTIF(socialMarkup.`twitter:site`) AS twitter_site,
  COUNTIF(socialMarkup.`twitter:site`) / COUNT(0) AS pct_twitter_site,
  COUNTIF(socialMarkup.`twitter:title`) AS twitter_title,
  COUNTIF(socialMarkup.`twitter:title`) / COUNT(0) AS pct_twitter_title,
  COUNTIF(socialMarkup.`twitter:image`) AS twitter_image,
  COUNTIF(socialMarkup.`twitter:image`) / COUNT(0) AS pct_twitter_image,
  COUNTIF(socialMarkup.`twitter:image:alt`) AS twitter_image_alt,
  COUNTIF(socialMarkup.`twitter:image:alt`) / COUNT(0) AS pct_twitter_image_alt,
  COUNTIF(socialMarkup.`twitter:description`) AS twitter_description,
  COUNTIF(socialMarkup.`twitter:description`) / COUNT(0) AS pct_twitter_description
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getSocialMarkup(payload) AS socialMarkup
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
ORDER BY
  client
