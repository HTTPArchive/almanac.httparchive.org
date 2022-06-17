CREATE TEMP FUNCTION parseCSS(stylesheet STRING) RETURNS STRING LANGUAGE js AS '''
try {
  var css = parse(stylesheet)
  return JSON.stringify(css);
} catch (e) {
  return null;
}
'''
OPTIONS (library = "gs://httparchive/lib/parse-css.js");

WITH external_stylesheets AS (
  SELECT
    date,
    client,
    page,
    url,
    body AS styles
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2022-06-01' AND
    type = 'css' AND
    LENGTH(body) < 3 * 1024 * 1024 # 3 MB
), inline_styles AS (
  SELECT
    date,
    client,
    page,
    'inline' AS url,
    styles
  FROM (
    SELECT
      date,
      client,
      page,
      url,
      body
    FROM
      `httparchive.almanac.summary_response_bodies`
    WHERE
      date = '2022-06-01' AND
      firstHtml),
    UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)<style[^>]*>(.*)</style>')) AS styles
  WHERE
    styles IS NOT NULL AND
    LENGTH(styles) > 0 AND
    LENGTH(styles) < 3 * 1024 * 1024 # 3 MB
), all_styles AS (
  SELECT
    *
  FROM
    external_stylesheets
  UNION ALL
  SELECT
    *
  FROM
    inline_styles
), parsed_css AS (
  SELECT
    date,
    client,
    page,
    url,
    parseCSS(styles) AS css
  FROM
    all_styles
)

SELECT
  date,
  client,
  page,
  url,
  css
FROM
  parsed_css
WHERE
  css IS NOT NULL
