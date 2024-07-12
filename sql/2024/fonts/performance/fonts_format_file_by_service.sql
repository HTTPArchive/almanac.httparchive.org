-- Section: Performance
-- Question: Which file formats are used broken down by service?

CREATE TEMPORARY FUNCTION FILE_FORMAT(url STRING, header STRING) AS (
  LOWER(COALESCE(
    REGEXP_EXTRACT(LOWER(header), r'(otf|sfnt|svg|ttf|woff2?|fontobject|opentype|truetype)'),
    REGEXP_EXTRACT(url, r'\.(\w+)(?:$|\?|#)'),
    header
  ))
);

CREATE TEMPORARY FUNCTION SERVICE(url STRING) AS (
  CASE
    WHEN REGEXP_CONTAINS(url, r'((use|fonts)\.typekit\.(net|com))|webfonts\.creativecloud\.com') THEN 'Adobe'
    WHEN REGEXP_CONTAINS(url, r'(fonts\.(gstatic|googleapis)\.com)|themes.googleusercontent.com/static/fonts|ssl.gstatic.com/fonts') THEN 'Google'
    WHEN REGEXP_CONTAINS(url, r'cloud\.typenetwork\.com') THEN 'typenetwork.com'
    WHEN REGEXP_CONTAINS(url, r'cloud\.typography\.com') THEN 'typography.com'
    WHEN REGEXP_CONTAINS(url, r'cloud\.webtype\.com') THEN 'webtype.com'
    WHEN REGEXP_CONTAINS(url, r'f\.fontdeck\.com') THEN 'fontdeck.com'
    WHEN REGEXP_CONTAINS(url, r'fast\.fonts\.(com|net)\/(jsapi|cssapi)') THEN 'fonts.com'
    WHEN REGEXP_CONTAINS(url, r'fnt\.webink\.com') THEN 'webink.com'
    WHEN REGEXP_CONTAINS(url, r'fontawesome\.com') THEN 'fontawesome.com'
    WHEN REGEXP_CONTAINS(url, r'fonts\.typonine\.com') THEN 'typonine.com'
    WHEN REGEXP_CONTAINS(url, r'fonts\.typotheque\.com') THEN 'typotheque.com'
    WHEN REGEXP_CONTAINS(url, r'typesquare\.com') THEN 'typesquare.com'
    WHEN REGEXP_CONTAINS(url, r'use\.edgefonts\.net') THEN 'edgefonts.net'
    WHEN REGEXP_CONTAINS(url, r'webfont\.fontplus\.jp') THEN 'fontplus.jp'
    WHEN REGEXP_CONTAINS(url, r'webfonts\.fontslive\.com') THEN 'fontslive.com'
    WHEN REGEXP_CONTAINS(url, r'webfonts\.fontstand\.com') THEN 'fontstand.com'
    WHEN REGEXP_CONTAINS(url, r'webfonts\.justanotherfoundry\.com') THEN 'justanotherfoundry.com'
    ELSE 'self-hosted'
  END
);

SELECT
  client,
  SERVICE(url) AS service,
  FILE_FORMAT(url, header.value) AS format,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`,
  UNNEST(response_headers) AS header
WHERE
  date = '2024-06-01' AND
  type = 'font' AND
  LOWER(header.name) = 'content-type' AND
  TRIM(header.value) != ''
GROUP BY
  client,
  service,
  format
ORDER BY
  client,
  service,
  proportion DESC
