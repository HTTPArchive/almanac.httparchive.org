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

WITH
fonts AS (
  SELECT
    client,
    SERVICE(url) AS service,
    url,
    AVG(PARSE_NUMERIC(header.value)) AS size
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS header
  WHERE
    date = '2024-06-01' AND
    type = 'font' AND
    LOWER(header.name) = 'content-length' AND
    TRIM(header.value) != ''
  GROUP BY
    client,
    service,
    url
)

SELECT
  client,
  service,
  percentile,
  COUNT(DISTINCT url) AS count,
  APPROX_QUANTILES(size, 1000)[OFFSET(percentile * 10)] AS size
FROM
  fonts,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  service,
  percentile
ORDER BY
  client,
  service,
  percentile
