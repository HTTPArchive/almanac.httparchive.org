SELECT
  client,
  LOWER(COALESCE(
    REGEXP_EXTRACT(LOWER(header.value), r'(otf|sfnt|svg|ttf|woff2?|fontobject|opentype|truetype)'),
    REGEXP_EXTRACT(url, r'\.(\w+)(?:$|\?|#)'),
    header.value
  )) AS format,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`,
  UNNEST(response_headers) AS header
WHERE
  date = '2024-06-01' AND
  type = 'font' AND
  LOWER(header.name) = 'content-type' AND
  TRIM(header.value) != '' AND
  NOT (
    REGEXP_CONTAINS(url, r'(fonts\.(gstatic|googleapis)\.com)|(themes.googleusercontent.com/static/fonts)|(ssl.gstatic.com/fonts/)') OR
    REGEXP_CONTAINS(url, r'(use\.edgefonts\.net|webfonts\.creativecloud\.com)') OR
    REGEXP_CONTAINS(url, r'(use|fonts)\.typekit\.(net|com)') OR
    REGEXP_CONTAINS(url, r'cloud\.typenetwork\.com') OR
    REGEXP_CONTAINS(url, r'cloud\.typography\.com') OR
    REGEXP_CONTAINS(url, r'cloud\.webtype\.com') OR
    REGEXP_CONTAINS(url, r'f\.fontdeck\.com') OR
    REGEXP_CONTAINS(url, r'fast\.fonts\.(com|net)\/(jsapi|cssapi)') OR
    REGEXP_CONTAINS(url, r'fnt\.webink\.com') OR
    REGEXP_CONTAINS(url, r'fontawesome\.com') OR
    REGEXP_CONTAINS(url, r'fonts\.typonine\.com') OR
    REGEXP_CONTAINS(url, r'fonts\.typotheque\.com') OR
    REGEXP_CONTAINS(url, r'typesquare\.com') OR
    REGEXP_CONTAINS(url, r'webfont\.fontplus\.jp') OR
    REGEXP_CONTAINS(url, r'webfonts\.fontslive\.com') OR
    REGEXP_CONTAINS(url, r'webfonts\.fontstand\.com') OR
    REGEXP_CONTAINS(url, r'webfonts\.justanotherfoundry\.com')
  )
GROUP BY
  client,
  format
ORDER BY
  client,
  proportion DESC
