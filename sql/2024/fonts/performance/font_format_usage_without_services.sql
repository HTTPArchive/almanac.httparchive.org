#standardSQL
#font_formats
SELECT
  client,
  LOWER(IFNULL(REGEXP_EXTRACT(mimeType, '/(?:x-)?(?:font-)?(.*)'), ext)) AS mime_type,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2022-06-01' AND
  type = 'font' AND
  mimeType != '' AND
  NOT (REGEXP_CONTAINS(url, r'(fonts\.(gstatic|googleapis)\.com)|(themes.googleusercontent.com/static/fonts)|(ssl.gstatic.com/fonts/)') OR
    REGEXP_CONTAINS(url, r'(use|fonts)\.typekit\.(net|com)') OR
    REGEXP_CONTAINS(url, r'(use\.edgefonts\.net|webfonts\.creativecloud\.com)') OR
    REGEXP_CONTAINS(url, r'fast\.fonts\.(com|net)\/(jsapi|cssapi)') OR
    REGEXP_CONTAINS(url, r'f\.fontdeck\.com') OR
    REGEXP_CONTAINS(url, r'cloud\.webtype\.com') OR
    REGEXP_CONTAINS(url, r'cloud\.typenetwork\.com') OR
    REGEXP_CONTAINS(url, r'cloud\.typography\.com') OR
    REGEXP_CONTAINS(url, r'fnt\.webink\.com') OR
    REGEXP_CONTAINS(url, r'fonts\.typotheque\.com') OR
    REGEXP_CONTAINS(url, r'webfonts\.fontstand\.com') OR
    REGEXP_CONTAINS(url, r'typesquare\.com') OR
    REGEXP_CONTAINS(url, r'webfont\.fontplus\.jp') OR
    REGEXP_CONTAINS(url, r'fontawesome\.com') OR
    REGEXP_CONTAINS(url, r'webfonts\.fontslive\.com') OR
    REGEXP_CONTAINS(url, r'webfonts\.justanotherfoundry\.com') OR
    REGEXP_CONTAINS(url, r'fonts\.typonine\.com'))
GROUP BY
  client,
  mime_type
ORDER BY
  client,
  pct DESC
