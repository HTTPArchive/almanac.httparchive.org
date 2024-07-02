SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS total,
  APPROX_QUANTILES(KiB_size, 1000)[
    OFFSET(percentile * 10)] AS KiB_size
FROM (
  SELECT
    url,
    client,
    percentile,
    respBodySize / 1024 AS KiB_size
  FROM
    `httparchive.almanac.requests`,
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
  WHERE
    date = '2022-06-01' AND
    type = 'font' AND
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
      REGEXP_CONTAINS(url, r'fonts\.typonine\.com')))
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
